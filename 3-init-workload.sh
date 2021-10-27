CONTEXT_US_EAST_1=ctring@cockroachdb.us-east-1.eksctl.io

kubectl create -f cockroach/license.yaml --context $CONTEXT_US_EAST_1
kubectl create -f cockroach/workload-init.yaml --context $CONTEXT_US_EAST_1