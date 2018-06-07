# bds-headless-client-example
Sample Brightspace Data Sets headless client using OAuth 2.0 refresh tokens

| Brightspace Community Article | Version Used in Article |
| ----------------------------- | ----------------------- |
| [Brightspace Data Sets - Headless (Non-Interactive) Client Example](https://community.brightspace.com/s/article/ka1610000000poFAAQ/Brightspace-Data-Sets-Headless-Non-Interactive-Client-Example) | [1.0.0](https://github.com/Brightspace/bds-headless-client-example/tree/1.0.0)
| [Brightspace Data Sets - Differential Data Sets Client Example](https://community.brightspace.com/s/article/ka3610000005uzcAAA/Brightspace-Data-Sets-Differential-Data-Sets-Client-Example) | [1.1.0](https://github.com/Brightspace/bds-headless-client-example/tree/1.1.0)
| [Brightspace Data Sets - Additive Changes Support Client Example](https://community.brightspace.com/s/article/ka3610000005uzhAAA/Brightspace-Data-Sets-Additive-Changes-Support-Client-Example) | [1.2.0](https://github.com/Brightspace/bds-headless-client-example/tree/1.2.0)

## Prerequisites

* [Brightspace Data
  Sets](https://community.brightspace.com/s/question/0D56100000xrq5eCAA/)
* [Registered OAuth 2.0
  application](http://docs.valence.desire2learn.com/basic/oauth2.html) and
  corresponding [refresh
  token](https://community.brightspace.com/s/article/ka1610000000pYqAAI/How-to-obtain-an-OAuth-2-0-Refresh-Token)
  with scope `datahub:dataexports:*`
* [Python 3](https://www.python.org/)
  * This example was tested using Python 3.6

## Setup

* Dependent libraries installed by running `python -m pip install -r
  requirements.txt`
* A file named `config.json` based on the [sample file](config-sample.json)
  * Note: this file contains sensitive information, and its file permissions
    should be set so that it is only readable by the user running this script
    (e.g. `chmod 600 config.json`)

### Configs

| key           | Value                                       |
| ------------- | ------------------------------------------- |
| bspace_url    | E.g. `https://myschool.brightspace.com`     |
| client_id     | From OAuth 2.0 application registration     |
| client_secret | From OAuth 2.0 application registration     |
| refresh_token | From `Prerequisites`                        |

### Folder Structure

The following outlines the minimum number of files that should be present before
using this script.

```
.
+-- config.json
+-- main.py
```

## Usage

```bash
python main.py
```

