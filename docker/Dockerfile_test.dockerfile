FROM python:3.8

WORKDIR /home/microblog

COPY requirements requirements
COPY requirements.txt microblog.py test.sh ./

RUN python -m venv .venv
RUN .venv/bin/pip3 install -r ./requirements.txt
RUN .venv/bin/pip3 install make

RUN chmod +x test.sh
ENTRYPOINT ["sh", "./test.sh"]
