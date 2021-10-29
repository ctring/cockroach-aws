#!/bin/bash

source "0-regions.sh"

kubectl port-forward -n $REGIONS service/cockroachdb 26257 8080