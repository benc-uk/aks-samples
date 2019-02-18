#!/bin/bash
set -e

# Load external input variables
source vars.sh

echo "...Creating resource group..."
az group create -n $resGrp -l $location -o table

echo "...Creating VNet and subnet..."
az network vnet create -g $resGrp -n $vnetName \
 --address-prefix "10.0.0.0/8" \
 --subnet-name $subnetName --subnet-prefix "10.1.0.0/16" -o table

subnetId=$(az network vnet subnet show -n $subnetName \
 -g $resGrp --vnet-name $vnetName --query "id" -o tsv)

echo "...Creating Log Analytics workspace..."
az resource create --resource-type Microsoft.OperationalInsights/workspaces \
 -n $logWorkspaceName \
 -g $resGrp \
 -l $location \
 -p '{}' -o table

workspaceId=$(az resource show -n $logWorkspaceName -g $resGrp --resource-type Microsoft.OperationalInsights/workspaces --query "id" -o tsv)
echo $workspaceId

echo "...Creating AKS cluster..."
az aks create \
 --resource-group $resGrp \
 --name $clusterName \
 --location westeurope \
 --dns-name-prefix $clusterName \
 --kubernetes-version $kubeVersion \
 --node-vm-size $vmSize \
 --node-count 3 \
 --enable-vmss \
 --enable-cluster-autoscaler \
 --min-count 3 \
 --max-count 6 \
 --enable-addons http_application_routing,monitoring \
 --network-plugin azure \
 --vnet-subnet-id $subnetId \
 --workspace-resource-id $workspaceId \
 --verbose
