#!/bin/bash

source ~/INSTALL/0_variables.sh


sudo apt-get update
sudo apt-get install open-iscsi
sudo service open-iscsi restart

sudo cat /etc/iscsi/initiatorname.iscsi

sudo service open-iscsi status

kubectl create ns openebs
kubectl create rolebinding -n openebs ibm-privileged-clusterrole --clusterrole=ibm-privileged-clusterrole --group=system:serviceaccounts:openebs



mkdir ~/temp
cd ~/temp

git clone https://github.com/openebs/openebs.git
cd openebs/k8s

helm install --namespace openebs --name openebs --set jiva.replicas=2 charts/openebs --tls


kubectl apply -f openebs-storageclasses.yaml
kubectl get sc

