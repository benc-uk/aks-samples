# OAuth2 Proxy
This demo sets up a reverse OAuth2 proxy in your Kubernetes cluster allowing you to protect applications behind an authentication & login flow. It is based on this example: https://github.com/kubernetes/ingress-nginx/tree/master/docs/examples/auth/oauth-external-auth

No code changes to the app are required.

It uses [OAuth2 Proxy](https://pusher.github.io/oauth2_proxy/) and the NGINX Ingress Controller (the AKS HTTP Application Routing add-on is supported)

Two examples of identity provider are provided; one using GitHub and one Azure AD (also called the [Microsoft identity platform](https://docs.microsoft.com/en-us/azure/active-directory/develop/))

## Pre-reqs
- NGINX Ingress Controller installed or AKS HTTP Application Routing add-on
- DNS setup with domain name pointing at your Kubernetes ingress
- TLS cert for that domain, this can be done with cert-manager

Configuring of DNS, the ingress controller and cert-manager is outside the scope of this scenario

## Pre-Setup: GitHub
- Register new OAuth app following these steps: https://pusher.github.io/oauth2_proxy/auth-configuration#github-auth-provider
- Make a note of the client id and secret
- Modify `oauth2-proxy-github.yaml` and set `OAUTH2_PROXY_CLIENT_ID` and `OAUTH2_PROXY_CLIENT_SECRET`. Place a random string in `OAUTH2_PROXY_COOKIE_SECRET`
- Run `kubectl apply -f oauth2-proxy-github.yaml`
  
## Pre-Setup: Azure AD
- Register new Azure AD application following these steps: https://docs.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app
  - Ensure the app is setup for web authentication
  - Ensure the redirect URL is correctly set e.g. `https://__YOUR_DOMAIN__/oauth2/callback`
- Make a note of the client id and secret, also your tenant id.
- Modify `oauth2-proxy-azure.yaml` and set `OAUTH2_PROXY_CLIENT_ID`, `OAUTH2_PROXY_CLIENT_SECRET` and also `OAUTH2_AZURE_TENANT`. Place a random string in `OAUTH2_PROXY_COOKIE_SECRET`
- Run `kubectl apply -f oauth2-proxy-azure.yaml`
  
## Deploy & Test App
- Modify `app.yaml` and change the domain name and TLS secret. Change `kubernetes.io/ingress.class` as required
- Run `kubectl apply -f app.yaml`
- Access the site in your browser to be redirected to the relevant provider for login

## Tips
For the `OAUTH2_PROXY_COOKIE_SECRET` you can generate a random 16 byte string value, with the following command:
```bash
docker run -ti --rm python:3-alpine python -c 'import secrets,base64; print(base64.b64encode(base64.b64encode(secrets.token_bytes(16))));'
```     
