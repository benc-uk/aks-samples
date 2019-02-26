#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Error! Provide 'http' or 'https' to script"
    exit
fi

ingressType=$1

echo "Deploy ingress"
kubectl apply -f ingress-$ingressType.yaml

echo "Deploy frontend"
kubectl apply -f frontend.yaml

echo "Deploy MongoDB"
kubectl apply -f mongodb.yaml

echo "Data API"
kubectl apply -f data-api.yaml
kubectl get all -l scenario=1b

../common/get-url.sh $1

echo "Show Logs"
kubectl logs deploy/data-api -f
