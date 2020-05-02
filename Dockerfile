FROM python:3

WORKDIR /app/

COPY requirements.txt /app/
RUN apt update && apt install -y build-essential gcc musl-dev libffi-dev \
    && pip install -r requirements.txt 

COPY GrafanaDatastoreServer.py /app/

EXPOSE 7124 
ENV REDIS_HOST=192.168.0.118
ENV REDIS_PORT=6380

CMD /app/GrafanaDatastoreServer.py --redis-server $REDIS_HOST --redis-port $REDIS_PORT
