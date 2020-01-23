#!/bin/bash

source ~/INSTALL/0_variables.sh


kubectl create ns razee
kubectl create rolebinding -n razee ibm-privileged-clusterrole --clusterrole=ibm-privileged-clusterrole --group=system:serviceaccounts:razee


kubectl apply -f https://github.com/razee-io/Kapitan-delta/releases/latest/download/resource.yaml

kubectl apply -f https://github.com/razee-io/Razee/releases/latest/download/resource.yaml

kubectl get pods -n razee

kubectl logs deploy/razeedash-api -n razee

kubectl patch service -n razee razeedash-lb -p '{"spec": {"type":"NodePort"}}'
kubectl patch service -n razee razeedash-lb -p '{"spec": {"ports": [ { "port": 8080, "nodePort": 31888 } ] } }'
kubectl patch service -n razee razeedash-api-lb -p '{"spec": {"type":"NodePort"}}'
kubectl patch service -n razee razeedash-api-lb -p '{"spec": {"ports": [ { "port": 8081, "nodePort": 31889 } ] } }'


RAZEEDASH_LB=$PUBLIC_IP
RAZEEDASH_API_LB=$PUBLIC_IP

kubectl create configmap razeedash-config -n razee \
  --from-literal=root_url=http://"${RAZEEDASH_LB}":31888/ \
  --from-literal=razeedash_api_url=http://"${RAZEEDASH_API_LB}":31889/



