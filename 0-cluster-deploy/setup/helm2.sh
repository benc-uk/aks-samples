#!/bin/bash

#
# Install Helm binary
#
curl -L https://git.io/get_helm.sh | bash

#
# Apply Helm RBAC for AKS
#
kubectl apply -f helm-rbac.yaml

#
# Init Helm
#
helm init --history-max 200 --service-account tiller --node-selectors "beta.kubernetes.io/os=linux"
