#!/bin/bash
context=ctring@cockroachdb.us-east-1.eksctl.io

kubectl create -f cockroach/license.yaml --context $context
kubectl create -f cockroach/workload-init.yaml --context $context