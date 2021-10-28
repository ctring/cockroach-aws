#!/bin/bash
# https://www.cockroachlabs.com/docs/stable/orchestrate-cockroachdb-with-kubernetes-multi-cluster.html?filters=eks

namespace-and-dns-lb() {
  region=$1
  context=ctring@cockroachdb.$region.eksctl.io
  kubectl create namespace $region --context $context
  kubectl apply -f setup/dns-lb-eks.yaml --context $context
}

namespace-and-dns-lb us-east-1
# namespace-and-dns-lb us-east-2

# https://www.cockroachlabs.com/docs/stable/orchestrate-cockroachdb-with-kubernetes-multi-cluster.html?filters=eks#configure-coredns
read -p "Update the ConfigMap then press ENTER to continue"

configmap() {
  region=$1
  kubectl apply -f setup/configmap-$region.yaml --context ctring@cockroachdb.$region.eksctl.io
}

configmap us-east-1
configmap us-east-2
