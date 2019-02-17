#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Error! Provide 'http' or 'https' to script"
    exit
fi

ingressType=$1

# Including DemoMagic
source ../common/demo-magic.sh
# Defining Type Speed
TYPE_SPEED=2000
# Defining Custom prompt
DEMO_PROMPT="${green2}\u${WHITE}:${blue2}\w${yellow}$ "

# Deploy ingress
pe "kubectl apply -f ingress-$ingressType.yaml"
pe "kubectl describe ingress/smilr-ingress"

# Deploy frontend
pe "kubectl apply -f frontend.yaml"
pe "kubectl get all -l app=frontend"

# Mongo
pe "kubectl apply -f mongodb.yaml"

# Data API
pe "kubectl apply -f data-api.yaml"
pe "kubectl get all -l app=data-api"

# Show Logs
pe "kubectl logs deploy/data-api"

pe "kubectl get ingress/smilr-ingress -o json | jq -r \".spec.rules[0].host\""
#fqdn=$(kubectl get ingress/smilr-ingress -o json | jq -r ".spec.rules[0].host")

# printf "\n### Checking DNS\n"
# nslookup $fqdn
# printf "\nApp should be available at $ingressType://$fqdn \n\n"