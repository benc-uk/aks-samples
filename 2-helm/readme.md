# 2. Using Helm

This deploys the same Smilr app as scenarios 1a/1b/1c but uses a Helm chart instead. Unlike the other scenarios it deploys MongoDB using packaging dependencies on the Helm 'stable charts' repo, showing how Helm can be used as a package manager

Concepts covered:
- Helm Charts
- Helm Dependencies

---

# Prerequsites / Behind the scenes
- [Install Helm into AKS](https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm)
- `helm dependency update smilr`
- Copy `values.sample.yaml` to `myvalues.yaml` and modify as needed

# Running The Scenario
A. Use the the end to end magic demo script, this creates a Helm release called 'demo'
```
./demo.sh
```

B. Manually run commands

1. Deploy everything
    ```
    helm upgrade -i <<release-name>> smilr -f myvalues.yaml
    ```

# Clean Up
```
helm delete --purge <<release-name>>
```
