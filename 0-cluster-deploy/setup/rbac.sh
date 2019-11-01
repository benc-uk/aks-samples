#
# RBAC for Dashboard
#
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

#
# RBAC for Helm 2 Tiller
#
kubectl apply -f ./rbac-helm.yaml

#
# RBAC for Container Insights / Azure Monitor
#
kubectl apply -f ./rbac-container-insights.yaml
