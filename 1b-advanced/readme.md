# 1b. Microservices - Ingress, DNS and HTTPS

This scenario builds on 1a and is intended to show a more typical real world way of deploying to Kubernetes.

Concepts covered:
- Ingress
- External DNS
- Liveness Probes
- Persistent Volumes 

Optional:
- TLS certs for HTTPS (via Let's Encrypt)

This stands up a demo microservices and SPA app called Smilr with three simple services in your cluster using Deployments and uses an Ingress for external access

![app diagram](https://smilr.benco.io/etc/kube-scenario-b.png)

See the [main Smilr project](https://smilr.benco.io) and the [Smilr deployment docs](https://smilr.benco.io/kubernetes/#scenario-b---advanced) for more details on what the app does and how it functions.

---

# Prerequsites / Behind the scenes
This scenario assumes you are using the *'HTTP application routing add-on'* enabled in your AKS cluster. This comes with a free public DNS Zone in Azure with an auto generated named ending in **.aksapp.io**

If you have your own Ingress controller installed with either static DNS records or the [ExternalDNS](https://github.com/kubernetes-incubator/external-dns) extension setup, then they can be used instead, see section below

The *'HTTP application routing add-on'* will dynamically add and remove public DNS records for you based on the hosts you specify in your ingress rules, however it is too slow for most demos. It can be around 5 mins before the record is created and further time for the record to propagate through DNS, accessing the app URL before DNS is setup can result in cached results and further delay (10~15 mins)  

Therefor it is strongly advised to setup the DNS record for the name you are going to use ahead of time

1. Copy `vars.sample.sh` to `vars.sh` and edit the values to match your AKS cluster
2. Run `create-dns.sh` passing it a suitable DNS name prefix for your app, e.g. `smilr`
    ```
    ../common/create-dns.sh smilr
    ```
    This script detects the routing add-on DNS zone for your cluster, as well as the external IP of your ingress. It creates an A record in the DNS zone pointing to your ingress IP

3. Edit **ingress-http.yaml** and change `host` to match the name returned by the script. The `create-dns.sh` script will output the host value you should use, it will look something like `smilr.f0dfafed36164c7faac0.westeurope.aksapp.io` but the random string and region will differ.


# Running The Scenario
A. Use the the end to end magic demo script, pass `http` as the input to the script
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


# Clean Up
```
../common/remove.sh
```

# Advanced: Manual DNS and Ingress
If not using the *'HTTP application routing add-on'* and have your own DNS domain/zone plus have manually installed an ingress controller (e.g. NGINX), the steps are broadly the same.
- Create an A record pointing to the public IP of your ingress controller's service (exercise left to reader).  
- Edit **ingress-http.yaml** and change `host` to match your FQDN
- Edit **ingress-http.yaml** and change `kubernetes.io/ingress.class` to match the ingress you are using, e.g. `nginx` if using NGINX 


# Advanced: HTTPS and TLS Certs
To use HTTPS, TLS certs need to be issued and used. Let's Encrypt can provide free certs and [cert-manager](https://github.com/jetstack/cert-manager) is a standard way to integrate Let's Encrypt with Kubernetes and automatically issue certs

1. Install cert-manager. [Follow these steps](https://docs.cert-manager.io/en/latest/getting-started/install.html)
2. Change the email address in the **extra/issuer.yaml** file, you can use any valid email address
3. Install the cert issuer. Note. We use the staging Let's Encrypt endpoint as the production endpoint has ***extremely*** strict rate limits and the aksapp.io domain is often blocked
    ```
    kubectl apply -f extra/issuer.yaml
    ```
4. The certificate might take a little while to validate and be issued the first time
5. Run the scenarios but pass `https` to the `demo.sh` script (e.g. `./demo.sh https`) or apply  `ingress-https.yaml` if deploying manually with kubectl
6. Note. You might get a warning about the cert in the browser as it's issued by the staging service, you may have to ignore the error (e.g. click on 'advanced' or 'proceed to site'). One option to avoid the error is to install the 'Fake LE Intermediate X1' cert in your trusted root certs but this is not recommended 