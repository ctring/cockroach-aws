#!/bin/bash
source "0-regions.sh"

dir=${DIR:="."}
suffix=${SUFFIX}

if [[ -n $suffix ]]; then
  suffix="-$suffix"
fi

dirsuffix=$dir/crdb$suffix
mkdir -p $dirsuffix

for region in ${REGIONS[@]}; do
  kubectl logs workload-run$suffix --context ctring@cockroachdb.$region.eksctl.io > $dirsuffix/$region
done
