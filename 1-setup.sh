#!/bin/bash
# https://www.cockroachlabs.com/docs/stable/orchestrate-cockroachdb-with-kubernetes-multi-cluster.html?filters=eks

source "0-regions.sh"

namespace-and-dns-lb() {
  region=$1
  context=ctring@cockroachdb.$region.eksctl.io
  kubectl create namespace $region --context $context
  kubectl apply -f setup/dns-lb-eks.yaml --context $context
}

for region in ${REGIONS[@]}; do
  namespace-and-dns-lb $region
done

# https://www.cockroachlabs.com/docs/stable/orchestrate-cockroachdb-with-kubernetes-multi-cluster.html?filters=eks#configure-coredns
read -p "Update the ConfigMap then press ENTER to continue"

configmap() {
  region=$1
  kubectl apply -f setup/configmap-$region.yaml --context ctring@cockroachdb.$region.eksctl.io
}

cd setup && python3 genconfigmap.py && cd ..

for region in ${REGIONS[@]}; do
  configmap $region
done
