#!/bin/bash

echo
kubectl get ingress/smilr-ingress -o jsonpath="...App is available at ${1}://{.spec.rules[0].host}/{\"\n\"}"
echo