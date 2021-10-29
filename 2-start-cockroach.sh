#!/bin/bash
# https://www.cockroachlabs.com/docs/stable/orchestrate-cockroachdb-with-kubernetes-multi-cluster.html?filters=eks

source "0-regions.sh"

JOIN=""

for region in ${REGIONS[@]}
do
  JOIN+="cockroachdb-0.cockroachdb.$region,"
  JOIN+="cockroachdb-1.cockroachdb.$region,"
  JOIN+="cockroachdb-2.cockroachdb.$region,"
done

start-cockroach() {
  region=$1
  cpu="16"
  memory="120Gi"
  cache="12Gi"
  maxsqlmemory="12Gi"
  storemem="90Gi"

  cat cockroach/cockroach.yaml |\
    REGION=$region              \
    CPU=$cpu                    \
    MEMORY=$memory              \
    JOIN=$JOIN                  \
    CACHE=$cache                \
    MAXSQLMEMORY=$maxsqlmemory  \
    STOREMEM=$storemem          \
    envsubst                   |\
    kubectl create --context ctring@cockroachdb.$region.eksctl.io -n $region -f -
}

for region in ${REGIONS[@]}; do
  start-cockroach $region
done