#!/bin/bash
# https://www.cockroachlabs.com/docs/stable/orchestrate-cockroachdb-with-kubernetes-multi-cluster.html?filters=eks

start-cockroach() {
  region=$1
  join="cockroachdb-0.cockroachdb.us-east-1,
        cockroachdb-1.cockroachdb.us-east-1,
        cockroachdb-2.cockroachdb.us-east-1,
        cockroachdb-0.cockroachdb.us-east-2,
        cockroachdb-1.cockroachdb.us-east-2,
        cockroachdb-2.cockroachdb.us-east-2"
  cat cockroach/$region.yaml |\
    CPU=16 MEMORY=116Gi JOIN=$join envsubst |\
    kubectl create --context ctring@cockroachdb.$region.eksctl.io -n $region -f -
}

start-cockroach us-east-1
start-cockroach us-east-2

kubectl create -f cockroach/init.yaml --context ctring@cockroachdb.us-east-1.eksctl.io