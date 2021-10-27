CONTEXT_US_EAST_1=ctring@cockroachdb.us-east-1.eksctl.io
CONTEXT_US_EAST_2=ctring@cockroachdb.us-east-2.eksctl.io

cat cockroach/workload-run.yaml |\
  REGION=0 THETA=0.1 LOCAL_PCT=90 DURATION=10 envsubst |\
  kubectl create --context $CONTEXT_US_EAST_1 -f -

cat cockroach/workload-run.yaml |\
  REGION=0 THETA=0.1 LOCAL_PCT=90 DURATION=10 envsubst |\
  kubectl create --context $CONTEXT_US_EAST_2 -f -