# AKS Samples
Samples, feature demos and examples for Azure Kubernetes Service (AKS)

This repo is a collection of live samples & demos to run in AKS, to demonstrate various AKS and Kubernetes features & scenarios. 

Basic familiarity with Kubernetes is assumed, provided are scripts, sample apps, configs, YAML manifests and commands to technically run & stand-up the scenarios. However, these are not step by step guides with "speaker scripts" and slides on what to so say at each stage.

# Prerequisites

## Local Environment 
These samples can be run in [Azure Cloud Shell](https://shell.azure.com) or locally with the following setup:
- WSL Bash
- Azure CLI
- Kubectl
- Helm

## AKS Cluster
If you have a working cluster you can use that for many of the scenarios
See [0. Deploy AKS Cluster](./0-cluster-deploy/)

# Contents

- [0. Deploy AKS Cluster](./0-cluster-deploy/)
- [1a. Microservices: Basics](./1a-basic/)
- [1b. Microservices: Ingress & DNS](./1b-ingress)
- [1c. Microservices: Stateful Workloads](./1c-stateful)
- [2. Using Helm](./2-helm)
- [3. Monitoring (Prometheus)](./3-monitoring)
- [4. Pod Autoscaler (HPA)]
- [5. Cluster Autoscaler (CA)]
- [6. Virtual Nodes *](https://github.com/Azure-Samples/virtual-node-autoscale/)
- [7. Machine Learning and KubeFlow *](https://github.com/Azure/kubeflow-labs)
