#!/bin/bash

source "0-regions.sh"

SUFFIX=${SUFFIX:=1}

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

for region in ${REGIONS[@]}; do
  get-results $region
done
