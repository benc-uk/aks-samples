# Setup summary
This installs everything into a namespace called **vnodes**
```
kubectl create namespace vnodes
cd 6-vnodes-mine
kubectl apply -f ./prom-operator.yaml -n vnodes
kubectl apply -f ./prometheus-config/prometheus -n vnodes
kubectl expose pod prometheus-prometheus-0 --port 9090 --target-port 9090 -n vnodes
helm install stable/prometheus-adapter --name prometheus-adaptor --namespace vnodes -f ./prometheus-config/prometheus-adapter/values.yaml
```

# Grafana
Reuse the Grafana instance deployed in **[3-monitoring](../3-monitoring)**

- Add second Prometheus data source and point it at `http://prometheus-prometheus-0.vnodes.svc.cluster.local:9090` name the data source **Prometheus-VNode**
- Import the dashboard `grafana-dash-rps.json`

# Run store app
Change `store-values.yaml` especially the `ingress.host` value to match your setup 
```
helm install ../6-virtual-nodes/charts/online-store --name online-store --namespace vnodes -f ./store-values.yaml
```

# Hit with requests
Change host as required
```
hey -z 30m -c 3 http://store.k.benco.io/
```