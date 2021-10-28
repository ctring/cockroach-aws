# https://www.cockroachlabs.com/docs/stable/orchestrate-cockroachdb-with-kubernetes-multi-cluster.html?filters=eks

CONTEXT_US_EAST_1=ctring@cockroachdb.us-east-1.eksctl.io
CONTEXT_US_EAST_2=ctring@cockroachdb.us-east-2.eksctl.io

kubectl create namespace us-east-1 --context $CONTEXT_US_EAST_1
kubectl create namespace us-east-2 --context $CONTEXT_US_EAST_2

kubectl apply -f setup/dns-lb-eks.yaml --context $CONTEXT_US_EAST_1
kubectl apply -f setup/dns-lb-eks.yaml --context $CONTEXT_US_EAST_2

read -p "Update the ConfigMap then press ENTER to continue"

kubectl apply -f setup/configmap-us-east-1 --context $CONTEXT_US_EAST_1
kubectl apply -f setup/configmap-us-east-2 --context $CONTEXT_US_EAST_2