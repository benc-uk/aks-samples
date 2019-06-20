# 4. Horizontal Pod Autoscaler
Simple demo of the Kubernetes Horizontal Pod Autoscaler (HPA). Using [a Node.js demo web app](https://github.com/benc-uk/nodejs-demoapp), setting up a HPA to scale on CPU usage and then hitting the deployed apps with multiple requests using `hey`. The deployment will scale across several pods

# Prerequsites / Behind the scenes
This scenario assumes you are using the *'HTTP application routing add-on'* enabled in your AKS cluster. This comes with a free public DNS Zone in Azure with an auto generated named ending in **.aksapp.io**

See full pre-reqs in [scenario 1b](../1b-advanced)

1. Copy `vars.sample.sh` to `vars.sh` and edit the values to match your AKS cluster
2. Run `create-dns.sh` passing it a suitable DNS name prefix for your app, e.g. `nodeapp`
    ```
    ../common/create-dns.sh nodeapp
    ```
    This script detects the routing add-on DNS zone for your cluster, as well as the external IP of your ingress. It creates an A record in the DNS zone pointing to your ingress IP

3. Edit **node-app.yaml** and change `host` to match the name returned by the script. The `create-dns.sh` script will output the host value you should use, it will look something like `nodeapp.f0dfafed36164c7faac0.westeurope.aksapp.io` but the random string and region will differ.


# Deploy
```
cd 4-autoscale-pods
kubectl apply -f .
```
Access the app at the hostname you specified 

# Watch Pods and HPA
Run in split pane terminal or multiple windows
```
kubectl get pods -l scenario=4 --watch
```
```
kubectl get hpa/nodeapp --watch
```

# Hit with Requests
Change URL to the hostname you specified  
```
hey -z 20m -c 2 http://nodeapp.{{CHANGEME}.{{CHANGEME}}.aksapp.io/info
```
