#!/bin/bash
region_idx=${REGION_IDX:=0}
theta=${THETA:=0.1}
local_pct=${LOCAL_PCT:=100}
duration=${DURATION:=10}

run() {
  region=$1
  cat cockroach/workload-run.yaml |\
    REGION_IDX=$region_idx THETA=$theta LOCAL_PCT=$local_pct DURATION=$duration NAMESPACE=$region SUFFIX="-$SUFFIX" envsubst |\
    kubectl create --context ctring@cockroachdb.$region.eksctl.io -f -
}

run us-east-1
run us-east-2