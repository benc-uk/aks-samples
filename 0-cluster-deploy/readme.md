# Deploy AKS - deploy.sh
This bash script `deploy.sh`, stands-up AKS with the features enabled required for most of the demo scenarios

- Cluster Autoscaler
- VMSS
- Windows Nodes
- Virtual Nodes
- Network Policy
- Container Insights monitoring
- VNet integration (advanced networking, or "Azure CNI")
- RBAC
- HTTP routing add-on 

If you have an existing cluster with these features, then go ahead and use it.  
You can also use the Azure Portal, I won't judge you.

The script isn't intended cover every eventuality and assumes you have things like SSH keys in the default locations. The script deploys a new VNet and Log Analytics Workspace for the cluster to use, if you want to use existing resources for these, you will need to edit the script, an exercise left to the reader.

## Configuring
You must copy the provided `vars.sample.sh` file to `vars.sh` and edit the settings values in there before running:

## Preview Features

***Oct 2019:*** Some features used by this script and cluster are in preview, so prior to running

- An Azure CLI extension is required, make sure you are running at least v0.4.0 of the `aks-preview` extension
    ```
    az extension add --name aks-preview
    ```

- Enable preview features

    ```
    az feature register --name WindowsPreview --namespace Microsoft.ContainerService
    ```

    Check the status of the registrations with the following
    ```
    az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService')].{Name:name,State:properties.state}"
    ```

    It can sometimes take over 20 minutes for the features to register. Once registered, **it is important that you re-register the `Microsoft.ContainerService` provider**
    ```
    az provider register --namespace Microsoft.ContainerService
    ```

## Running
Run the script
```
./deploy.sh
```
