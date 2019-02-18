#!/bin/bash

# Including DemoMagic
source ../common/demo-magic.sh
# Defining Type Speed
TYPE_SPEED=20
# Defining Custom prompt
DEMO_PROMPT="${green2}\u${WHITE}:${blue2}\w${yellow}$ "

pe "kubectl apply -f frontend.yaml"

pe "kubectl apply -f mongodb.yaml"

pe "kubectl apply -f data-api.yaml"

pe "kubectl get all -l scenario=1a"

pe "../common/check-ip.sh frontend-svc"
