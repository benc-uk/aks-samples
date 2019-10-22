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

#
# Deploy issuers
#
kubectl apply -f issuer-prod.yaml
kubectl apply -f issuer-staging.yaml