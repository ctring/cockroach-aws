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
  cpu="15"
  memory="27Gi"
  cache="500Mi"
  maxsqlmemory="500Mi"
  storemem="26Gi"

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

read -p "Press ENTER to init the cluster."

context=ctring@cockroachdb.$REGIONS.eksctl.io
kubectl delete -f cockroach/init.yaml --context $context --ignore-not-found
kubectl create -f cockroach/init.yaml --context $context