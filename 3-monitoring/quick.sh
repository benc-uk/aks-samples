#!/bin/bash

kubectl create namespace monitoring

helm install --name prometheus stable/prometheus --namespace monitoring

helm install --name grafana stable/grafana --namespace monitoring --set persistence.enabled=true,image.tag=6.0.2

passwd=$(kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode)
echo "Grafana admin password is $passwd"

export GRAFANA_POD_NAME=$(kubectl get pods --namespace monitoring -l "app=grafana,release=grafana" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace monitoring port-forward $GRAFANA_POD_NAME 3000:3000
