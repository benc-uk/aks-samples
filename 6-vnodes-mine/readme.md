# Setup Summary
```
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/bundle.yaml
kubectl apply -f online-store/prometheus-config/prometheus
kubectl expose pod prometheus-prometheus-0 --port 9090 --target-port 9090
helm install stable/prometheus-adapter --name prometheus-adaptor -f ./online-store/prometheus-config/prometheus-adapter/values.yaml
helm install stable/grafana --name grafana -f grafana/values.yaml
```

# Run Store App
```
helm install ../6-virtual-nodes/charts/online-store --name online-store -f ./myvalues.yaml
```


# Access Grafana
```
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
echo -e "\n\n"
export POD_NAME=$(kubectl get pods --namespace default -l "app=grafana,release=grafana" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace default port-forward $POD_NAME 3000
```