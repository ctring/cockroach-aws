#!/bin/bash

source "0-regions.sh"

regions=""
local_region=""
for i in ${!REGIONS[@]}; do
  if (( $i > 0 )); then 
    regions+=","
  else
    local_region=${REGIONS[$i]}
  fi
  regions+=${REGIONS[$i]}
done

context=ctring@cockroachdb.$local_region.eksctl.io

kubectl delete -f cockroach/license.yaml --context $context --ignore-not-found
kubectl create -f cockroach/license.yaml --context $context

read -p "Make sure that the license is applied. Press ENTER to continue."

kubectl delete -f cockroach/workload-init.yaml --context $context --ignore-not-found
cat cockroach/workload-init.yaml |\
  REGIONS=$regions                \
  LOCAL_REGION=$local_region      \
  envsubst                       |\
  kubectl create --context $context -f -