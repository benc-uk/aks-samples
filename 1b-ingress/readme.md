# 1b. Smilr - Ingress, DNS and HTTPS

This scenario builds on 1a and is intended to show a more typical real world way of deploying to Kubernetes.

Concepts covered:
- Ingress
- External DNS
- Liveness Probes
- StatefulSets & Persistent Volumes

Optional:
- TLS certs for HTTPS (via Let's Encrypt)

This stands up a demo microservices and SPA app called Smilr with three simple services in your cluster using Deployments, StatefulSets and Ingress for external access

![app diagram](https://smilr.benco.io/etc/kube-scenario-b.png)

See the [main Smilr project](https://smilr.benco.io) and the [Smilr deployment docs](https://smilr.benco.io/kubernetes/#option-2---direct-deployment) for more details on what the app does and how it functions.

---

# Prerequsites / Behind the scenes
This scenario assumes you are using the *'HTTP application routing add-on'* enabled in your AKS cluster. This comes with a free public DNS Zone in Azure with an auto generated named ending in **.aksapp.io**

If you have your own Ingress controller installed with either static DNS records or the [ExternalDNS](https://github.com/kubernetes-incubator/external-dns) extension setup, then they can be used instead, see section [Advanced](#advanced) below

The *'HTTP application routing add-on'* will dynamically add and remove public DNS records for you based on the hosts you specify in your ingress rules, however it is too slow for most demos. It can be around 5 mins before the record is created and further time for the record to propagate through DNS, accessing the app URL before DNS is setup can result in cached results and further delay (10~15 mins)  

Therefor it is strongly advised to setup the DNS record for the name you are going to use ahead of time

1. Copy `vars.sample.sh` to `vars.sh` and edit the value for `appDnsName` to a suitable DNS name prefix for your app, e.g. `smilr` or `demo`. The save & exit

2. Run
    ```
    ./create-dns.sh
    ```

3. Edit **ingress-http.yaml** and change `host:` to match your `appDnsName` with your AKS DNS zone name appended. The `create-dns.sh` script will output the host value you should use


# Running The Scenario

1. Deploy everything
    ```
    kubectl apply -f mongodb.yaml
    kubectl apply -f data-api.yaml
    kubectl apply -f frontend.yaml
    kubectl apply -f ingress-http.yaml
    ```

2. Wait for the *PersistentVolume* to provision and mount to the MongoDb pod. This will take additional time the first time it is run, after the 1st time it will be faster as the volume will be reused. Check the status with

    ```
    kubectl describe pod -l app=mongodb,scenario=1b
    ```
3. If using the *'HTTP application routing add-on'* and you haven't set a static DNS A record up, then a dynamic one will be added, but it will take several minutes

3. Access the DNS name you put into the `host:` of **ingress-http.yaml** in the browser

# Advanced

2. If using static DNS and your own ingress controller, create an A record pointing to the external IP of the ingress controller
