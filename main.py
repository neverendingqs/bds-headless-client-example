import collections
import datetime
import io
import json
import logging
import os
import zipfile

import psycopg2
import requests
from requests.auth import HTTPBasicAuth

DataSetMetadata = collections.namedtuple('DataSetMetadata', ['plugin', 'table'])

logger = logging.getLogger(__name__)

API_VERSION = '1.15'
AUTH_SERVICE = 'https://auth.brightspace.com/'
CONFIG_LOCATION = 'config.json'

DATA_SET_METADATA = [
    DataSetMetadata(
        plugin='b12a4203-3169-4dbb-9e6b-e979fc1620a9',
        table='assignment_submission_details'
    ),
    DataSetMetadata(
        plugin='041dde83-3a29-4a37-97de-9ee615318111',
        table='assignment_submissions'
    ),
    DataSetMetadata(
        plugin='d9923de9-de6a-41ea-a63e-e8fd771b7b93',
        table='assignment_summary'
    ),
    DataSetMetadata(
        plugin='7b98d9e0-4339-406d-bd78-0821729817ae',
        table='attendance_details'
    ),
    DataSetMetadata(
        plugin='7e16311c-d302-45da-afd9-98af90706ccb',
        table='content_objects'
    ),
    DataSetMetadata(
        plugin='1c50d2a2-990b-4897-a8c2-89a7a3202514',
        table='content_user_completion'
    ),
    DataSetMetadata(
        plugin='428AD0CB-6203-486D-BE85-ADB01C79578B',
        table='content_user_progress'
    ),
    DataSetMetadata(
        plugin='ac51124b-6038-4b04-a186-92eb4cef40b0',
        table='discussion_posts_read_status'
    ),
    DataSetMetadata(
        plugin='bce64f34-acee-415e-aceb-e3a38ddf476f',
        table='discussion_posts'
    ),
    DataSetMetadata(
        plugin='793668a8-2c58-4e5e-b263-412d28d5703f',
        table='grade_objects'
    ),
    DataSetMetadata(
        plugin='9d8a96b4-8145-416d-bd18-11402bc58f8d',
        table='grade_results'
    ),
    DataSetMetadata(
        plugin='74308e1e-b0c0-437c-b3df-3a19e3b6f305',
        table='grade_schemes'
    ),
    DataSetMetadata(
        plugin='61726e1b-bf42-4cab-910d-e5a226dec4f0',
        table='org_unit_ancestors'
    ),
    DataSetMetadata(
        plugin='07a9e561-e22f-4e82-8dd6-7bfb14c91776',
        table='org_units'
    ),
    DataSetMetadata(
        plugin='f1623581-c5d7-4562-93fe-6ad16010c96b',
        table='quiz_attempts'
    ),
    DataSetMetadata(
        plugin='14a07c0a-2166-41d6-859a-2e0b7fc54be1',
        table='quiz_question_answer_options'
    ),
    DataSetMetadata(
        plugin='7b530c69-4462-48a9-9acc-64a84fda6b37',
        table='quiz_question_answers'
    ),
    DataSetMetadata(
        plugin='56069703-048e-4151-a4ce-a2155d582d79',
        table='quiz_questions'
    ),
    DataSetMetadata(
        plugin='24d9051c-509a-4ea3-81bc-735f36bf94f0',
        table='quiz_user_answer_responses'
    ),
    DataSetMetadata(
        plugin='93d6063b-61d4-4629-a6af-b4fad71f8c55',
        table='quiz_user_answers'
    ),
    DataSetMetadata(
        plugin='cd7fa762-841e-48c5-abd7-6379b84963bf',
        table='rubric_assessment'
    ),
    DataSetMetadata(
        plugin='612e3196-52ad-42bd-b460-8b850f7a7be1',
        table='rubric_assessment_criteria'
    ),
    DataSetMetadata(
        plugin='533f84c8-b2ad-4688-94dc-c839952e9c4f',
        table='user_enrollments'
    ),
    DataSetMetadata(
        plugin='20794201-b8fe-4010-9197-9f4997f91531',
        table='user_logins'
    ),
    DataSetMetadata(
        plugin='1d6d722e-b572-456f-97c1-d526570daa6b',
        table='users'
    )
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
            'scope': 'core:*:*'
        },
        auth=HTTPBasicAuth(config['client_id'], config['client_secret'])
    )

    if response.status_code != 200:
        logger.error('Status code: %s; content: %s', response.status_code, response.text)
        response.raise_for_status()

    return response.json()

def put_config(config):
    with open(CONFIG_LOCATION, 'w') as f:
        json.dump(config, f, sort_keys=True)

def update_db(db_conn_params, table, csv_data):
    '''
    In a single transaction, update the table by:
    - Loading the CSV data into a temporary table
    - Run an update or insert query to update the main table with the data in
      the temporary table
    - Delete the temporary table

    Note: using '.format()' because the table name can not be a SQL
    parameter. This is safe in this context because 'table' is a
    hardcoded value. In other contexts, always use SQL parameters
    when possible.
    '''
    with psycopg2.connect(**db_conn_params) as conn:
        with conn.cursor() as cur:
            cur.execute(
                '''
                CREATE TEMP TABLE tmp_{table} AS
                    SELECT *
                    FROM {table}
                    LIMIT 0;
                '''
                .format(table=table)
            )

            cur.copy_expert(
                '''
                COPY tmp_{table}
                FROM STDIN
                WITH (FORMAT CSV, HEADER);
                '''
                .format(table=table),
                csv_data
            )

            upsert_query_file = os.path.join(
                os.path.dirname(os.path.abspath(__file__)),
                'schema',
                'upserts',
                'upsert_{table}.sql'.format(table=table)
            )
            with open(upsert_query_file) as upsert_query:
                cur.execute(upsert_query.read())

            cur.execute('DROP TABLE tmp_{table}'.format(table=table))

        conn.commit()

if __name__ == '__main__':
    config = get_config()
    config['auth_service'] = config.get('auth_service', AUTH_SERVICE)

    token_response = trade_in_refresh_token(config)

    # Store the new refresh token for getting a new access token next run
    config['refresh_token'] = token_response['refresh_token']
    put_config(config)

    db_conn_params = {
        'host': config['dbhost'],
        'dbname': config['dbname'],
        'user': config['dbuser'],
        'password': config['dbpassword']
    }

    for plugin, table in DATA_SET_METADATA:
        # Call {bspace_url}/d2l/api/lp/{lp_version}/dataExport/bds/list for a list
        # of all available data sets
        endpoint = '{bspace_url}/d2l/api/lp/{lp_version}/dataExport/bds/download/{plugin_id}'.format(
            bspace_url=config['bspace_url'],
            lp_version=API_VERSION,
            plugin_id=plugin
        )
        headers = {'Authorization': 'Bearer {}'.format(token_response['access_token'])}
        response = requests.get(endpoint, headers=headers)

        if response.status_code != 200:
            logger.error('Status code: %s; content: %s', response.status_code, response.text)
            response.raise_for_status()

        with io.BytesIO(response.content) as response_stream:
            with zipfile.ZipFile(response_stream) as zipped_data_set:
                files = zipped_data_set.namelist()

                assert len(files) == 1
                csv_name = files[0]

                with zipped_data_set.open(csv_name) as csv_data:
                    update_db(db_conn_params, table, csv_data)
