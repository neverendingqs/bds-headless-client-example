import io
import json
import logging
import zipfile

import requests
from requests.auth import HTTPBasicAuth

logger = logging.getLogger(__name__)

API_VERSION = '1.18'
AUTH_SERVICE = 'https://auth.brightspace.com/'
CONFIG_LOCATION = 'config.json'

DATA_SET_PLUGINS = [
    '07a9e561-e22f-4e82-8dd6-7bfb14c91776', # Org units
    '793668a8-2c58-4e5e-b263-412d28d5703f', # Grade Objects
    '1d6d722e-b572-456f-97c1-d526570daa6b', # Users
    '9d8a96b4-8145-416d-bd18-11402bc58f8d', # Grade Results
    '533f84c8-b2ad-4688-94dc-c839952e9c4f'  # User Enrollments
]

def get_config():
    with open(CONFIG_LOCATION, 'r') as f:
        return json.load(f)

def trade_in_refresh_token(config):
    # https://tools.ietf.org/html/rfc6749#section-6
    response = requests.post(
        '{}/core/connect/token'.format(config['auth_service']),
        # Content-Type 'application/x-www-form-urlencoded'
        data={
            'grant_type': 'refresh_token',
            'refresh_token': config['refresh_token'],
            'scope': 'datahub:dataexports:*'
        },
        auth=HTTPBasicAuth(config['client_id'], config['client_secret'])
    )

    if response.status_code != 200:
        logger.error('Status code: %s; content: %s', response.status_code, response.text)
        response.raise_for_status()

    return response.json()

def put_config(config):
    with open(CONFIG_LOCATION, 'w') as f:
        json.dump(config, f, indent=4, sort_keys=True)

def get_with_auth(endpoint, access_token):
    headers = {'Authorization': 'Bearer {}'.format(token_response['access_token'])}
    response = requests.get(endpoint, headers=headers)

    if response.status_code != 200:
        logger.error('Status code: %s; content: %s', response.status_code, response.text)
        response.raise_for_status()

    return response

def get_plugin_link_mapping(config, access_token):
    data_sets = []
    next_page_url = '{bspace_url}/d2l/api/lp/{lp_version}/dataExport/bds'.format(
        bspace_url=config['bspace_url'],
        lp_version=API_VERSION
    )

    while next_page_url is not None:
        list_response = get_with_auth(next_page_url, access_token)
        list_json = list_response.json()

        data_sets += list_json['BrightspaceDataSets']
        next_page_url = list_json['NextPageUrl']

    return { d['PluginId']: d['DownloadLink'] for d in data_sets }

def unzip(response_content):
    with io.BytesIO(response_content) as response_stream:
        with zipfile.ZipFile(response_stream) as zipped_data_set:
            files = zipped_data_set.namelist()

            assert len(files) == 1
            csv_name = files[0]

            zipped_data_set.extractall('data_sets')

if __name__ == '__main__':
    config = get_config()
    config['auth_service'] = config.get('auth_service', AUTH_SERVICE)

    token_response = trade_in_refresh_token(config)

    # Store the new refresh token for getting a new access token next run
    config['refresh_token'] = token_response['refresh_token']
    put_config(config)

    plugin_to_link = get_plugin_link_mapping(config, token_response['access_token'])

    for plugin in DATA_SET_PLUGINS:
        response = get_with_auth(
            endpoint=plugin_to_link[plugin],
            access_token=token_response['access_token']
        )
        unzip(response.content)
