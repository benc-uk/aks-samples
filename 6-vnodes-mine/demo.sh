#!/bin/bash

# Including DemoMagic
source ../common/demo-magic.sh
# Defining Type Speed
TYPE_SPEED=20
# Defining Custom prompt
DEMO_PROMPT="${green2}\u${WHITE}:${blue2}\w${yellow}$ "

export GRAFANA_POD_NAME=$(kubectl get pods --namespace monitoring -l "app=grafana,release=grafana" -o jsonpath="{.items[0].metadata.name}")
pe "kubectl --namespace monitoring port-forward $GRAFANA_POD_NAME 3000:3000 &"

pe "helm install ../6-virtual-nodes/charts/online-store --name online-store --namespace vnodes -f ./store-values.yaml"
pe "helm ls"

pe "kubectl get po -n vnodes -l app=online-store"

echo -e "\nAccess the store at: http://store.k.benco.io/\n"

pe "kubectl get hpa -n vnodes"