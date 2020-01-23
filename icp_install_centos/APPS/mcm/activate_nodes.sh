#!/bin/bash
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Scaling up Multi Cloud manager"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"

# kubectl get deploy -o=custom-columns=NAME:.metadata.name -n kube-system  | grep mcm

source ~/INSTALL/0_variables.sh

kubectl scale deploy --replicas=1 -n kube-system mcmk-aws-ibm-mcmk-prod-klusterlet
kubectl scale deploy --replicas=1 -n kube-system mcmk-aws-ibm-mcmk-prod-weave-scope-app
kubectl scale deploy --replicas=1 -n kube-system mcmk-azure-ibm-mcmk-prod-klusterlet
kubectl scale deploy --replicas=1 -n kube-system mcmk-azure-ibm-mcmk-prod-weave-scope-app
kubectl scale deploy --replicas=1 -n kube-system mcmk-google-ibm-mcmk-prod-klusterlet
kubectl scale deploy --replicas=1 -n kube-system mcmk-google-ibm-mcmk-prod-weave-scope-app
kubectl scale deploy --replicas=1 -n kube-system mcmk-iks2-ibm-mcmk-prod-klusterlet
kubectl scale deploy --replicas=1 -n kube-system mcmk-iks2-ibm-mcmk-prod-weave-scope-app



kubectl scale deploy --replicas=1 -n kube-system mcmk-iks1-ibm-mcmk-prod-klusterlet
kubectl scale deploy --replicas=1 -n kube-system mcmk-iks1-ibm-mcmk-prod-weave-scope-app


kubectl scale deploy --replicas=0 -n kube-system mcmk-aws-ibm-mcmk-prod-klusterlet
kubectl scale deploy --replicas=0 -n kube-system mcmk-aws-ibm-mcmk-prod-weave-scope-app
kubectl scale deploy --replicas=0 -n kube-system mcmk-azure-ibm-mcmk-prod-klusterlet
kubectl scale deploy --replicas=0 -n kube-system mcmk-azure-ibm-mcmk-prod-weave-scope-app
kubectl scale deploy --replicas=0 -n kube-system mcmk-google-ibm-mcmk-prod-klusterlet
kubectl scale deploy --replicas=0 -n kube-system mcmk-google-ibm-mcmk-prod-weave-scope-app
kubectl scale deploy --replicas=0 -n kube-system mcmk-iks2-ibm-mcmk-prod-klusterlet
kubectl scale deploy --replicas=0 -n kube-system mcmk-iks2-ibm-mcmk-prod-weave-scope-app
0
0
0
kubectl scale deploy --replicas=01 -n kube-system mcmk-iks1-ibm-mcmk-prod-klusterlet
kubectl scale deploy --replicas=01 -n kube-system mcmk-iks1-ibm-mcmk-prod-weave-scope-app
