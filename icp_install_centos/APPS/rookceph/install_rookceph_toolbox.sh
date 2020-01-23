#!/bin/bash

source ~/INSTALL/0_variables.sh

#---------------------------------------------------------------------------------------------------------
# Create Toolbox for CommandLine Access
#---------------------------------------------------------------------------------------------------------
kubectl create -f toolbox.yaml
kubectl -n rook-ceph get pod
kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') bash
ceph status
ceph osd status
ceph df
rados df



