FROM python:3.12-slim

COPY requirements.txt requirements.txt
COPY pack pack
COPY models models

RUN pip install --no-cache-dir --upgrade pip
RUN pip install -r requirements.txt

CMD uvicorn pack.api:app --host 0.0.0.0 --port $PORT
