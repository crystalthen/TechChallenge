FROM python:3

WORKDIR /work

COPY requirements.txt ./

RUN pip install -r requirements.txt
