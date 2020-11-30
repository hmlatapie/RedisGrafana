# RedisGrafana 

Easy to use redis timeseries to grafana dashboard functionality

## First build RedisGrafana container
```bash
./RedisGrafana build
```

## Run grafana container on port 3000 (admin:admin)
```bash
./RedisGrafana grafana
```

## Create a RedisGrafana adapter for each redis timeseries instance
```bash
./RedisGrafana redisAdapter adapterPort redisPort
```

## Create grafana datasources for each adapterPort
1) using simplejson adapter type
2) enter: http://localhost:adapterPort as the data source
3) give grafana datasource a reasonable name

## Create grafana dashboards manually
1) select datasources, individual time series, etc... for graph panels as required

## Create grafana dashboards automatically
stay tuned!
