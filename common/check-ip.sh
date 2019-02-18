#!/bin/bash
# Pass the name of a service to check ie: sh check-endpoint.sh staging-voting-app-vote
# Will run forever...
external_ip=""
while [ -z $external_ip ]; do
  echo "...Waiting for '$1' to get public IP..."
  external_ip=$(kubectl get svc $1 --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
  [ -z "$external_ip" ] && sleep 10
done
echo "...Service '$1' has IP address: $external_ip"
echo -e "\n...Access in a browser with http://$external_ip/ \n"