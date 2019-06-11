#!/bin/bash

clear

# Including DemoMagic
source ../common/demo-magic.sh
# Defining Type Speed
TYPE_SPEED=20
# Defining Custom prompt
DEMO_PROMPT="${green2}\u${WHITE}:${blue2}\w${yellow}$ "

pe "az aks get-credentials -n aksdevcamp -g demo.devcamp"
pe "kubectl get nodes"
pe "kubectl create deploy demo --image=bencuk/nodejs-demoapp"
pe "kubectl get pods"
pe "kubectl expose deploy demo --target-port=3000 --port=80 --type=LoadBalancer"
pe "kubectl get svc -w"
