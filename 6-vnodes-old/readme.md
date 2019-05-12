```
kubectl autoscale deployment nodeapp --cpu-percent=50 --min=1 --max=10
```

```
helm install --name adapter stable/prometheus-adapter --namespace monitoring --set "prometheus.url=http://prometheus-server.monitoring.svc,prometheus.port=80"
```


```
hey -z 60s http://40.118.83.84/load
```