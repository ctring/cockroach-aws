#!/bin/bash

SUFFIX=test

get-results() {
  region=$1
  echo ==============================
  echo "    REGION $region          "
  echo ==============================
  context=ctring@cockroachdb.$region.eksctl.io
  pod_name=$(kubectl get pods --selector=job-name=workload-run-$SUFFIX --context $context -o name)
  kubectl logs $pod_name --context $context
  echo
}

get-results us-east-1
get-results us-east-2