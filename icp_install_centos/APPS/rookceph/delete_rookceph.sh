#!/bin/bash

cd ~/INSTALL/APPS/rookceph/rook/cluster/examples/kubernetes/ceph

kubectl delete -f storageclass-test.yaml
kubectl delete -f cluster-test.yaml
kubectl delete -f common.yaml
kubectl delete -f operator.yaml
