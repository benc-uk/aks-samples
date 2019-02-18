#!/bin/bash
set -e

# Load external input variables
source vars.sh

echo
kubectl get ingress/smilr-ingress -o json | jq -r --arg proto $1 ' "...App is available at \($proto)://\(.spec.rules[0].host)/"'
echo