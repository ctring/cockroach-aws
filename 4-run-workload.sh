#!/bin/bash
source "0-regions.sh"

hot=${HOT:=10000}
local_pct=${LOCAL_PCT:=90}
duration=${DURATION:=10}
suffix=${SUFFIX}
regions=""
concurrency=${CONCURRENCY:=16}

if [[ -n $suffix ]]; then
  suffix="-$suffix"
fi

for i in ${!REGIONS[@]}; do
  if (( $i > 0 )); then 
    regions+=","
  fi
  regions+=${REGIONS[$i]}
done

run() {
  region_idx=$1
  region=$2

  cat cockroach/workload-run.yaml |\
    NAMESPACE=$region              \
    SUFFIX=$suffix                 \
    envsubst                      |\
    kubectl delete --context ctring@cockroachdb.$region.eksctl.io --ignore-not-found -f -

  cat cockroach/workload-run.yaml |\
    REGION_IDX=$region_idx         \
    REGIONS=$regions               \
    HOT=$hot                       \
    LOCAL_PCT=$local_pct           \
    DURATION=$duration             \
    NAMESPACE=$region              \
    SUFFIX=$suffix                 \
    CONCURRENCY=$concurrency       \
    envsubst                      |\
    kubectl create --context ctring@cockroachdb.$region.eksctl.io -f -
}

for i in ${!REGIONS[@]}; do
  run $i ${REGIONS[$i]}
done
