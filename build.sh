#!/usr/bin/env bash
set -e
set -x

python3 -m venv dist/venv
source dist/venv/bin/activate
python3 -m pip install -r requirements.txt
python3 -m pip install -r build_requirements.txt
shiv --site-packages /usrdata/local/pyenv/versions/fastapi/lib/python3.11/site-packages \
	--compressed \
	-o simple_api \
	-e simple_api.__main__:main src/ \
	--upgrade
