minikube start
kubectl create namespace region-0
kubectl create namespace region-1
kubectl create namespace region-2
kubectl create -f cockroachdb-0.yaml -n region-0
kubectl create -f cockroachdb-1.yaml -n region-1
kubectl create -f cockroachdb-2.yaml -n region-2
kubectl create -f init.yaml