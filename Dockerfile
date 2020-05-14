FROM continuumio/miniconda3

WORKDIR /app/

COPY requirements.txt /app/
RUN conda install -y redis 
RUN apt update && apt install -y build-essential gcc musl-dev libffi-dev 
RUN pip install -r requirements.txt 

COPY GrafanaDatastoreServer.py /app/

EXPOSE 7124 
ENV REDIS_HOST=192.168.0.118
ENV REDIS_PORT=6380

CMD /app/GrafanaDatastoreServer.py --host 127.0.0.1 --port 7124 --redis-server $REDISTIMESERIES_PORT_6379_TCP_ADDR --redis-port 6379 

