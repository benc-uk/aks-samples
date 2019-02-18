#!/bin/bash
set -e

publicIp=$(kubectl get svc addon-http-application-routing-nginx-ingress -n kube-system -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
dnsIp=$(dig +short $1)

echo "...Kubernetes ingress public IP is $publicIp"

while [ "$dnsIp" != "$publicIp" ]; do
  echo "...'$1' resolved to: $dnsIp, checking again in 10 seconds"
  sleep 10
  dnsIp=$(dig +short $1)
done

echo "DNS resolved to $dnsIp, this matches ingress!"