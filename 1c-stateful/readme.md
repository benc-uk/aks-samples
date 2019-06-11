# 1c. Microservices - Stateful Workloads

This scenario is an extension of 1b and simply adds persistence to the MongoDB workload. In many cases you can dive straight into this scenario.  
It has been split out like this in order to try and not cram too much into a single scenario

**NOTE.** Everything that applies to scenario 1b, also applies here, [so go read that first](../1b-ingress/)

Additional concepts covered:
- Stateful workloads
- StatefulSets
- PersistentVolumes
- Storage Classes

This stands up a demo microservices and SPA app called Smilr with three simple services in your cluster using Deployments, StatefulSets and uses an Ingress for external access

The MongoDB workload will be stood up as a StatefulSet and use a PersistentVolumeClaim to claim and mount a PersistentVolume in order to store and persist it's data.

![app diagram](https://smilr.benco.io/etc/kube-scenario-b.png)

See the [main Smilr project](https://smilr.benco.io) and the [Smilr deployment docs](https://smilr.benco.io/kubernetes/#scenario-b---advanced) for more details on what the app does and how it functions.

---

# Prerequsites / Behind the scenes
See [scenario 1b for prereqs](../1b-ingress/)

No additional prerequsites 

# Running The Scenario
A. Use the the end to end magic demo script, pass `http` or `https` as the input to the script
```
./demo.sh http
```

B. Manually run commands

1. Deploy everything
    ```
    kubectl apply -f mongodb.yaml
    kubectl apply -f data-api.yaml
    kubectl apply -f frontend.yaml
    kubectl apply -f ingress-http.yaml
    ```

2. Access the DNS name you put into the `host:` of **ingress-http.yaml** in the browser, or run `./get-url.sh http`

3. Autoscale

```
kubectl autoscale deployment data-api --cpu-percent=30 --min=1 --max=20
```

# Clean Up
```
../common/remove.sh
```
