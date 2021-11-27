FROM python:3.8-alpine
RUN adduser -D microblog

WORKDIR /home/microblog

# COPY . .
COPY app app
COPY migrations migrations
COPY requirements requirements
COPY requirements.txt microblog.py boot.sh ./
COPY gunicorn_config.py gunicorn_config.py

# hadolint ignore=DL3013,DL3018
RUN apk --no-cache add --virtual build-dependencies libffi-dev openssl-dev py-pip build-base \
  && pip install --upgrade pip \
  && pip install -r requirements.txt \
  && apk del build-dependencies

RUN python -m venv .venv
ENV FLASK_APP microblog.py
RUN .venv/bin/pip3 install -r ./requirements.txt

RUN chmod +x boot.sh

RUN chown -R microblog:microblog ./
USER microblog

ENV prometheus_multiproc_dir /tmp

EXPOSE 5000
ENTRYPOINT ["sh", "./boot.sh"]