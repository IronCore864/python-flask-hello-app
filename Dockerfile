FROM python:alpine

MAINTAINER Tiexin Guo "guotiexin@gmail.com"

RUN pip3 install --upgrade gunicorn 

COPY . /app

WORKDIR /app

RUN pip install -r requirements.txt

CMD gunicorn app:app --log-file - --bind 0.0.0.0:5000

