#!/bin/bash

source "0-regions.sh"

JOIN=""

stop-cockroach() {
  region=$1

  cat cockroach/cockroach.yaml |\
    REGION=$region              \
    envsubst                   |\
    kubectl delete --context ctring@cockroachdb.$region.eksctl.io -n $region -f -
}

for region in ${REGIONS[@]}; do
  stop-cockroach $region
done