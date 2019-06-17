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

Set up DNS record for the store app
```
../common/create-dns.sh store
```

# Grafana
Reuse the Grafana instance deployed in **[3-monitoring](../3-monitoring)**

- Add second Prometheus data source and point it at `http://prometheus-prometheus-0.vnodes.svc.cluster.local:9090` name the data source **Prometheus-VNode**
- Import the dashboard `grafana-dash-rps.json`

Access with
```
export GRAFANA_POD_NAME=$(kubectl get pods --namespace monitoring -l "app=grafana,release=grafana" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace monitoring port-forward $GRAFANA_POD_NAME 3000:3000
```

# Run store app
Change `store-values.yaml` especially the `ingress.host` value to match your setup, e.g. `store.f0dfafed36164c7faac0.westeurope.aksapp.io`

Then run:
```
helm install ../6-virtual-nodes/charts/online-store --name online-store --namespace vnodes -f ./store-values.yaml
```

Watch what is going on:
```
kubectl get hpa -n vnodes -w
kubectl get po -l app=online-store -n vnodes -w
```

# Hit with requests to trigger scaling
This requires that `hey` is [installed](https://github.com/rakyll/hey) 
```
export STORE_HOST=$(grep -oP 'host: \K.*' store-values.yaml)
hey -z 30m -c 3 http://$STORE_HOST/
```