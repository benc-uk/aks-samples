#!/bin/bash
set -e

# Load external input variables
source vars.sh

echo "...Creating resource group..."
az group create -n $resGrp -l $location -o table

echo "...Creating main AKS VNet and subnet..."
az network vnet create -g $resGrp -n $vnetName \
 --address-prefix "10.55.0.0/16" \
 --subnet-name $subnetName --subnet-prefix "10.55.1.0/24" -o table

echo "...Creating subnet for Virtual Nodes..."
az network vnet subnet create -g $resGrp --vnet-name $vnetName \
 --name $vnodesSubnetName \
 --address-prefixes "10.55.2.0/24" -o table

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

#
# Cluster features/options 
# - Advanced network, autoscaler, VMSS, monitoring, RBAC, HTTP routing
#
echo "...Creating AKS cluster..."
az aks create \
 --resource-group $resGrp \
 --name $clusterName \
 --location westeurope \
 --dns-name-prefix $clusterName \
 --kubernetes-version $kubeVersion \
 --node-vm-size $vmSize \
 --node-count $minNodes \
 --enable-vmss \
 --enable-cluster-autoscaler \
 --min-count $minNodes \
 --max-count $maxNodes \
 --enable-addons http_application_routing,monitoring \
 --network-plugin azure \
 --vnet-subnet-id $subnetId \
 --workspace-resource-id $workspaceId \
 --windows-admin-username $winAdminUser \
 --windows-admin-password $winAdminPwd \
 --verbose

echo "..."
echo "...Cluster is ready, running post deploy steps..."
echo "..."

#
# Post creation things
#

# echo "...Enabling Virtual Nodes..."
# az aks enable-addons \
#   --resource-group $resGrp \
#   --name $clusterName \
#   --addons virtual-node \
#   --subnet-name $vnodesSubnetName

echo "...Adding Windows node pool, this will take some time..."
az aks nodepool add \
  --resource-group $resGrp \
  --cluster-name $clusterName \
  --os-type Windows \
  --name win1 \
  --node-count $minNodes \
  --node-vm-size $vmSize \
  --kubernetes-version $kubeVersion \
