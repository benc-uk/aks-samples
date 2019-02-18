#!/bin/bash
set -e

# Load external input variables
source ../common/vars.sh
source vars.sh

# Local vars
ipName="smilr-api-staticip"

nodeResGrp=$(az aks show --resource-group $resGrp --name $aksName --query nodeResourceGroup -o tsv)
echo "...Will use resource group: $nodeResGrp"

echo "...Creating static public IP..."
az network public-ip create --dns-name $dnsPrefix \
 --resource-group $nodeResGrp --name $ipName \
 --allocation-method static -o table

az network public-ip show --resource-group $nodeResGrp --name $ipName --query "{ip:ipAddress, fqdn:dnsSettings.fqdn}"
