# dompointd
Fake daemon example to test Deb/Rpm build system
# Fastapi Demo project

[Python in Production](https://blog.ippon.tech/python-in-production-part-1-of-5/)

## Virtuális környezet

Kavarás, hogy ne Pyenv fusson.
```shell
exec -c bash
```

```shell
python3.10 -m venv venv
source venv/bin/activate
```

Kezdeti fájok:

### requirements.txt
```text
fastapi
uvicorn
```

### Install requirements

```shell
python -m pip install -r requirements.txt
```
### Project folders
```shell
mkdir -p src/dompointd
```
### setup.py
`src/setup.py`:
```python
#!/usr/bin/env python

from setuptools import setup, find_packages

setup(name='dompointd,
      version='0.5',
      description='A Simple API',
      author='Joozsef Varga',
      author_email='muszi@rubin.hu',
      url='https://rubin.hu/',
      packages=find_packages(),
     )
```

### Package fájlok
```shell
touch src/simple_api/{__init__.py,__main__.py,api.py}
```

### api.py
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def read_root():
    return {"Hello": "World"}
```
### Teszt
```shell
cd src/dompointd/
uvicorn api:app --reload
curl http://127.0.0.1:8000 
```
### main.py
```python
import uvicorn
from dompointd.api import app

def main():
    uvicorn.run(app)

if __name__ == "__main__":
    main()
```
### Installing Your Program as a Local Package
```shell
cd ..
python3 -m pip install .
```
### Test - as package
```shell
python3 dompointd
```
### Test - as Python code
```python
from simple_api.api import app
import uvicorn
uvicorn.run(app)
```
### Creating an Executable with Shiv
`build_requirements.txt`:
```text
shiv
src
```

`build.sh`:
```shell
#!/usr/bin/env bash
set -e
set -x

python3 -m venv dist/venv
source dist/venv/bin/activate
python3 -m pip install -r requirements.txt
python3 -m pip install -r build_requirements.txt
shiv --site-packages venv/lib/python3.10/site-packages \
	--compressed \
	-o simple_api \
	-e simple_api.__main__:main src/ \
	--upgrade
```
