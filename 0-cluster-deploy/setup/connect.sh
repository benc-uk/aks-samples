#!/bin/bash

# Load external input variables
source ../vars.sh

#
# Connect to AKS
#
az aks get-credentials -n $clusterName -g $resGrp
