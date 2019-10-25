#!/bin/bash

CERT_MGR_VER="0.11.0"

#
# Create namespace
#
kubectl create namespace cert-manager

#
# Deploy cert manager NOT using Helm
#
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v$CERT_MGR_VER/cert-manager.yaml --validate=false

echo "Waiting 90 secs, before creating issuers..."
sleep 90

#
# Deploy HTTP issuers
#
kubectl apply -f issuer-prod.yaml
kubectl apply -f issuer-staging.yaml

#
# For DNS issuers ONLY
# REMOVE if you're not using wildcard certs with a wildcard DNS zone
#
$SECRET="{{change-me}}"
kubectl create secret generic azuredns-config --from-literal=CLIENT_SECRET=$SECRET -n cert-manager

#
# Apply issuers
#
kubectl apply -f issuer-prod.yaml
kubectl apply -f issuer-staging.yaml