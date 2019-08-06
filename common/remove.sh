#!/bin/bash

kubectl delete statefulset/mongodb
kubectl delete deploy/mongodb
kubectl delete deploy/data-api
kubectl delete deploy/frontend
kubectl delete deploy/sentiment
kubectl delete svc/frontend-svc
kubectl delete svc/data-api-svc
kubectl delete svc/mongodb-svc
kubectl delete svc/sentiment-svc
kubectl delete ingress/smilr-ingress
