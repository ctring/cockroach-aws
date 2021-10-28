#!/bin/bash
# https://www.cockroachlabs.com/docs/stable/orchestrate-cockroachdb-with-kubernetes-multi-cluster.html?filters=eks

start-cockroach() {
  region=$1
  kubectl create -f cockroach/$region.yaml --context ctring@cockroachdb.$region.eksctl.io -n $region
}

start-cockroach us-east-1
start-cockroach us-east-2

kubectl create -f cockroach/init.yaml --context ctring@cockroachdb.us-east-1.eksctl.io