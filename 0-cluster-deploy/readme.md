# Deploy AKS - deploy.sh
This bash script `deploy.sh`, stands-up AKS with the features enabled required for most of the demo scenarios

- Cluster Autoscaler
- VMSS
- Container Insights monitoring
- VNet integration (advanced networking)
- RBAC
- HTTP routing add-on 

If you have an existing cluster with these features, then go ahead and use it.  
You can also use the Azure Portal, I won't judge you.

The script isn't intended cover every eventuality and assumes you have things like SSH keys in the default locations. The script deploys a new VNet and Log Analytics Workspace for the cluster to use, if you want to use existing resources for these, you will need to edit the script, an exercise left to the reader.

## Configuring
You must edit the settings in `vars.sh` before running

## Running

***Feb 2019*** The VMSS & cluster autoscaler features are in preview, so a CLI extension is required
```
az extension add --name aks-preview
```

Run the script
```
./deploy.sh
```
