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
TYPE_SPEED=20
# Defining Custom prompt
DEMO_PROMPT="${green2}\u${WHITE}:${blue2}\w${yellow}$ "

# Deploy ingress
pe "kubectl apply -f ingress-$ingressType.yaml"

# Deploy frontend
pe "kubectl apply -f frontend.yaml"

# Mongo
pe "kubectl apply -f mongodb.yaml"

# Data API
pe "kubectl apply -f data-api.yaml"
pe "kubectl get all -l scenario=1b"
pe "kubectl get ingress"

pe "../common/get-url.sh $1"

# Show Logs
#pe "kubectl logs deploy/data-api -f"
