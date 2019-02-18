#!/bin/bash

# Including DemoMagic
source ../common/demo-magic.sh
# Defining Type Speed
TYPE_SPEED=20
# Defining Custom prompt
DEMO_PROMPT="${green2}\u${WHITE}:${blue2}\w${yellow}$ "

pe "kubectl get pod,deploy -l scenario=1a"

pe "kubectl scale deploy/frontend --replicas=8"

pe "kubectl get pod,deploy -l app=frontend"

pe "kubectl scale deploy/data-api --replicas=5"

pe "kubectl get pod,deploy -l app=data-api"

p "watch -n 2 \"curl -s http://smilrstatic.westeurope.cloudapp.azure.com/api/info | jq -r .hostname\""
watch -n 2 "curl -s http://smilrstatic.westeurope.cloudapp.azure.com/api/info | jq -r .hostname"
