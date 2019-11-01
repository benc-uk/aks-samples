#set -e

linkerd check --pre
linkerd install | kubectl apply -f -
linkerd check