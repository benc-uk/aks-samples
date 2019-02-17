kubectl delete -f mongodb.yaml
kubectl delete -f data-api.yaml
kubectl delete -f frontend.yaml
kubectl delete ingress/smilr-ingress
kubectl get all