# Deploy AKS - deploy.sh
This bash script `deploy.sh`, stands-up AKS with the features enabled required for most of the demo scenarios

- Cluster Autoscaler
- VMSS
- Windows Nodes
- Virtual Nodes
- Container Insights monitoring
- VNet integration (advanced networking, or "Azure CNI")
- RBAC
- HTTP routing add-on 

If you have an existing cluster with these features, then go ahead and use it.  
You can also use the Azure Portal, I won't judge you.

The script isn't intended cover every eventuality and assumes you have things like SSH keys in the default locations. The script deploys a new VNet and Log Analytics Workspace for the cluster to use, if you want to use existing resources for these, you will need to edit the script, an exercise left to the reader.

## Configuring
You must copy the provided `vars.sample.sh` file to `vars.sh` and edit the settings values in there before running

## Preview Features

***May 2019:*** Several features used by this script and cluster are in preview, so some steps need to be taken prior to running

- An Azure CLI extension is required, make sure you are running at least v0.4.0 of the `aks-preview` extension
    ```
    az extension add --name aks-preview
    ```

- [Enable multiple node pools](https://docs.microsoft.com/en-us/azure/aks/use-multiple-node-pools#before-you-begin)

- [Enable Windows nodes]  
((Instructions redacted while still in private preview))

## Running
Run the script
```
./deploy.sh
```
