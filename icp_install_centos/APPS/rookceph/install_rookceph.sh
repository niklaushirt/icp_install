#!/bin/bash

source ~/INSTALL/0_variables.sh


#https://rook.io/docs/rook/v0.9/ceph-quickstart.html

#---------------------------------------------------------------------------------------------------------
# CREATE ROOK CEPH BASICS
#---------------------------------------------------------------------------------------------------------

mkdir -p ~/INSTALL/APPS/rookceph
cd ~/INSTALL/APPS/rookceph

git clone https://github.com/rook/rook.git
cd rook/cluster/examples/kubernetes/ceph

kubectl create ns rook-ceph
kubectl create rolebinding -n rook-ceph ibm-privileged-clusterrole --clusterrole=ibm-privileged-clusterrole --group=system:serviceaccounts:rook-ceph

kubectl create -f common.yaml
kubectl create -f operator.yaml

#---------------------------------------------------------------------------------------------------------
# CREATE ROOK CEPH Cluster
#---------------------------------------------------------------------------------------------------------
kubectl create -f cluster-test.yaml

kubectl get CephCluster -n rook-ceph

#---------------------------------------------------------------------------------------------------------
# Expose Dashboard on port 31999
#---------------------------------------------------------------------------------------------------------

kubectl patch service -n rook-ceph rook-ceph-mgr-dashboard -p '{"spec": {"type":"NodePort"}}'
kubectl patch service -n rook-ceph rook-ceph-mgr-dashboard -p '{"spec": {"ports": [ { "name": "https-dashboard", "port": 8443, "nodePort": 31999 } ] } }'



#---------------------------------------------------------------------------------------------------------
# CREATE ROOK CEPH BlockStorage
#---------------------------------------------------------------------------------------------------------
kubectl create -f storageclass-test.yaml

kubectl -n rook-ceph get pod

kubectl create -f blokpvc.yaml


#---------------------------------------------------------------------------------------------------------
# CREATE ROOK CEPH FS
#---------------------------------------------------------------------------------------------------------
#kubectl create -f filesystem.yaml





