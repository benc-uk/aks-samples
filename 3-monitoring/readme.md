# 3. Monitoring with Prometheus & Grafana

This simple scenario enables Prometheus & Grafana in your cluster and adds some pre-built dashboards showing various metrics, graphs and data points

Concepts covered:
- Prometheus
- Grafana
- Metrics

# Prerequsites / Behind the scenes
- [Install Helm into AKS](https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm)
- `kubectl create namespace monitoring`

# Install Prometheus

```
helm install --name prometheus stable/prometheus --namespace monitoring -f prometheus-values.yaml
```

# Install Grafana

Install Grafana using Helm
```
helm install --name grafana stable/grafana --namespace monitoring -f grafana-values.yaml
```

Once deployed get the default password for the `admin` user account
```
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

It might take 2-3 mins for Grafana to start the first time, you can check the status with `kubectl get po -n monitoring -l app=grafana`
Once started, forward the port to access Grafana portal. 
```
export GRAFANA_POD_NAME=$(kubectl get pods --namespace monitoring -l "app=grafana,release=grafana" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace monitoring port-forward $GRAFANA_POD_NAME 3000:3000
```

# Add Kubernetes dashboards to Grafana
- Access Grafana at http://localhost:3000/
- login with user `admin` and password obtained above
- Add a data source and pick 'Prometheus' 
  - URL is `http://prometheus-server.monitoring.svc.cluster.local`
  - Click 'Save & Test'
- Add dashboards (hover over the plus on the right menu, click 'Import').  
Some suggested dashboards to import are:
  - `8685` K8s Cluster Summary
  - `7249` Kubernetes Cluster
  - `5228` Kubernetes Capacity 
  - `8588` Kubernetes Deployment Statefulset Daemonset metrics 
  - `7562` Analysis by Pod
  - `5303` Kubernetes Deployment (Prometheus)
  - `7187` Kubernetes Resource Requests 
