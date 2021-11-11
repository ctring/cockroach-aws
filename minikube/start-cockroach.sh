kubectl create -f cockroachdb-0.yaml -n region-0
kubectl create -f cockroachdb-1.yaml -n region-1
kubectl create -f cockroachdb-2.yaml -n region-2
kubectl delete --ignore-not-found -f init.yaml
kubectl create -f init.yaml