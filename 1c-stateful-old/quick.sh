#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Error! Provide 'http' or 'https' to script"
    exit
fi

ingressType=$1


# Deploy ingress
kubectl apply -f ingress-$ingressType.yaml

# Deploy frontend
kubectl apply -f frontend.yaml

# Mongo
kubectl apply -f mongodb.yaml
kubectl get pvc

# Data API
kubectl apply -f data-api.yaml
kubectl get all -l scenario=1c

../common/get-url.sh $1

# Show Logs
kubectl logs deploy/data-api -f
