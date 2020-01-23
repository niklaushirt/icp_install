#!/bin/bash

source ~/INSTALL/0_variables.sh


# Create some Stuff
echo "Create some Stuff"
cd ~/INSTALL/
kubectl create namespace dev-namespace
kubectl create namespace test-namespace
kubectl create namespace prod-namespace

kubectl delete rolebinding -n cert-manager ibm-privileged-clusterrole
kubectl delete rolebinding -n dev-namespace ibm-privileged-clusterrole
kubectl delete rolebinding -n test-namespace ibm-privileged-clusterrole
kubectl delete rolebinding -n prod-namespace ibm-privileged-clusterrole

kubectl create rolebinding -n cert-manager ibm-privileged-clusterrole --clusterrole=ibm-privileged-clusterrole --group=system:serviceaccounts:cert-manager
kubectl create rolebinding -n dev-namespace ibm-privileged-clusterrole --clusterrole=ibm-privileged-clusterrole --group=system:serviceaccounts:dev-namespace
kubectl create rolebinding -n test-namespace ibm-privileged-clusterrole --clusterrole=ibm-privileged-clusterrole --group=system:serviceaccounts:test-namespace
kubectl create rolebinding -n prod-namespace ibm-privileged-clusterrole --clusterrole=ibm-privileged-clusterrole --group=system:serviceaccounts:prod-namespace

kubectl create -f ~/INSTALL/KUBE/CONFIG/devlimits_quota.yaml
kubectl create -f ~/INSTALL/KUBE/CONFIG/restricted_policy.yaml
kubectl create -f ~/INSTALL/KUBE/CONFIG/privileged_policy.yaml
kubectl create -f ~/INSTALL/KUBE/CONFIG/calico_demo.yaml
kubectl create -f ~/INSTALL/KUBE/CONFIG/clusterimagepolicy_all.yaml

kubectl create -f ~/INSTALL/KUBE/CONFIG/namespace_rolebindings.yaml

cat ~/INSTALL/KUBE/CONFIG/bashrc_add_stress.sh >> ~/.bashrc
