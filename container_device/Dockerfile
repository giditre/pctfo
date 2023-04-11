FROM python:3.11.2-alpine3.17

RUN apk add nmap

RUN pip install --upgrade pip
RUN pip install requests

WORKDIR /root

ADD invia.py .

RUN echo "Primo numero: 10" | base64 > info01.txt

RUN echo "Secondo numero: 1" > .info02.txt

RUN for N in $(seq -w 0 29); do mkdir -p "archivio/sezione$N"; done
RUN echo "Terzo numero: 3" > archivio/sezione27/info03.txt

CMD while true; do echo "Quarto numero: 11" | nc -lp 36000; sleep 0.1; done & sh
