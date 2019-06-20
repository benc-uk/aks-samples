#!/bin/bash
set -e

# Load external input variables
source ./common/vars.sh
appDnsName=$1

nodeResGrp=$(az aks show --resource-group $resGrp --name $aksName --query nodeResourceGroup -o tsv)
echo "...Will use resource group: $nodeResGrp"

zoneName=$(az aks show -n $aksName -g $resGrp --query "addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName" -o tsv)
echo "...Your AKS app routing DNS zone is: $zoneName"

publicIp=$(kubectl get svc addon-http-application-routing-nginx-ingress -n kube-system -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "...And point $appDnsName to: $publicIp"

az network dns record-set a add-record -g $nodeResGrp -z $zoneName -n $appDnsName -a $publicIp -o table || true

echo -e "\n Your ingress host should be set to: $appDnsName.$zoneName \n"
