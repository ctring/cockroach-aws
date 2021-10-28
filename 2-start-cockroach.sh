# https://www.cockroachlabs.com/docs/stable/orchestrate-cockroachdb-with-kubernetes-multi-cluster.html?filters=eks

CONTEXT_US_EAST_1=ctring@cockroachdb.us-east-1.eksctl.io
CONTEXT_US_EAST_2=ctring@cockroachdb.us-east-2.eksctl.io

kubectl create -f cockroach/us-east-1.yaml --context $CONTEXT_US_EAST_1 -n us-east-1
kubectl create -f cockroach/us-east-2.yaml --context $CONTEXT_US_EAST_2 -n us-east-2
kubectl create -f cockroach/init.yaml --context $CONTEXT_US_EAST_1