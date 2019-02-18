# 1a. Smilr - Basics

This scenario is designed to show the basics to audiences new to Kubernetes. It's worth stressing **this is not an optimal way to deploy such an app**, but it introduces basics to be built upon in scenarios 1b and 1c.

Concepts covered:
- YAML manifests
- Deployments & ReplicaSets
- Services: LoadBalancer & ClusterIP
- Manual scaling

This stands up a demo microservices and SPA app called Smilr with three simple services in your cluster using Deployments, and LoadBalancers for external access

![app diagram](https://smilr.benco.io/etc/kube-scenario-a.png)

See the [main Smilr project](https://smilr.benco.io) and the [Smilr deployment docs](https://smilr.benco.io/kubernetes/#option-2---direct-deployment) for more details on what the app does and how it functions.

---

# Prerequsites / Behind the scenes
As the app has a SPA frontend it requires that the frontend service is deployed with the public IP/DNS name of data-api component provided as config. This leads to some minor complexities

For this demo a static IP for the data-api is used. This simplifies things and stops needing either edit the YAML for each deployment or wait for external DNS propagation. 

1. Create static public IP with DNS name.  
Copy `vars.sample.sh` to `vars.sh` and edit & save. Then run

    ```
    ./create-ip.sh
    ```
    This will display the FQDN and the IP address when complete. 

2. Edit **data-api.yaml** and change the `loadBalancerIP` to the public IP address just created

3. Edit **frontend.yaml** and change the `API_ENDPOINT` to point to the FQDN just created. This is a URL so do not forget to include `http://` and trailing `/api`

# Running The Scenario
1. Deploy the data layer
    ```
    kubectl apply -f mongodb.yaml
    kubectl apply -f data-api.yaml
    kubectl apply -f frontend.yaml
    kubectl get svc frontend-svc -w
    ```
    Wait for `frontend-svc` to get an external IP address assigned, once it has, hit CTRL+C stop waiting. **Note.** This can take about 2 minutes in some cases, so be patient.  

2. The frontend-svc external IP address is where you can access the Smilr app, e.g. by visiting **http://{frontend-svc-ip}/** in your browser

# Tips & Advice
