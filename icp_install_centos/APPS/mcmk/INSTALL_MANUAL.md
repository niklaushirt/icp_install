
source ~/INSTALL/0_variables.sh


export HUB_IP=9.30.248.180:8443
export CLUSTER_NAME=icp-fyre-mcm
export CLUSTER_NAMESPACE=mcm-$CLUSTER_NAME

export CLUSTER_CLOUD=ICP
export CLUSTER_VENDOR=IBM
export CLUSTER_ENV=Prod
export CLUSTER_REGION=US 
export CLUSTER_DATACENTER=dallas 
export CLUSTER_OWNER=IT

export KUBECONFIG=kubeconfig
<COPY PASTE TARGET CLUSTER from Configure Client Web Interface>
unset KUBECONFIG


cloudctl login -a https://$HUB_IP --skip-ssl-validation -u admin -p admin -n kube-system
cloudctl mc cluster template $CLUSTER_NAME -n $CLUSTER_NAMESPACE > cluster-import.yaml

sed -i "s/environment: \"Dev\"/environment: \"$CLUSTER_ENV\"/" cluster-import.yaml
sed -i "s/region: \"US\"/region: \"$CLUSTER_REGION\"/g" cluster-import.yaml
sed -i "s/datacenter: \"us-east\"/datacenter: \"$CLUSTER_DATACENTER\"/g" cluster-import.yaml
sed -i "s/owner: \"owner\"/owner: \"$CLUSTER_OWNER\"/g" cluster-import.yaml


cloudctl mc cluster import -f cluster-import.yaml --cluster-kubeconfig kubeconfig --cluster-context mycluster-context  


cloudctl mc cluster remove local-cluster --cluster-kubeconfig kubeconfig --cluster-context mycluster-context --namespace mcm-local-cluster



[-n|--namespace {namespace}] [-C|--cluster-context {context}] [-K|--cluster-kubeconfig {path}] [-b|--bootstrap-namespace {namespace}]



[-b|--bootstrap-namespace {namespace}] [-t|--timeout {time}]

# LOCAL

export HUB_IP=9.30.248.180:8443
export CLUSTER_NAME=icp-mac
export CLUSTER_NAMESPACE=mcm-$CLUSTER_NAME

export CLUSTER_CLOUD=ICP
export CLUSTER_VENDOR=IBM
export CLUSTER_ENV=Dev
export CLUSTER_REGION=EU 
export CLUSTER_DATACENTER=geneva 
export CLUSTER_OWNER=IT


# HUB

export HUB_IP=9.30.248.180:8443
export CLUSTER_NAME=local-cluster
export CLUSTER_NAMESPACE=local-cluster

export CLUSTER_CLOUD=ICP
export CLUSTER_VENDOR=IBM
export CLUSTER_ENV=Prod
export CLUSTER_REGION=US 
export CLUSTER_DATACENTER=dallas 
export CLUSTER_OWNER=IT
local-cluster



sed -i 's/aaa/bbb/g' cluster-import.yaml
sed -i 's/aaa/bbb/g' cluster-import.yaml





# CONFIGS

## FYRE CONTROLLER

source ~/INSTALL/0_variables.sh
export CLUSTER_CLOUD=ICP
export CLUSTER_VENDOR=IBM
export CLUSTER_NAME=icp-fyre-controller
export CLUSTER_ENV=Prod
export CLUSTER_REGION=US \
export CLUSTER_DATACENTER=newyork \
export CLUSTER_OWNER=IT
export HUB_IP=https://9.30.119.132:8001
export HUB_TOKEN=replace

## FYRE BIG

source ~/INSTALL/0_variables.sh
export CLUSTER_CLOUD=ICP
export CLUSTER_VENDOR=IBM
export CLUSTER_NAME=icp-fyre-big
export CLUSTER_ENV=Dev
export CLUSTER_REGION=US \
export CLUSTER_DATACENTER=sanfrancisco \
export CLUSTER_OWNER=IT
export HUB_IP=https://9.30.119.132:8001
HUB_TOKEN=replace

## ICP LOCAL

source ~/INSTALL/0_variables.sh
export CLUSTER_CLOUD=ICP
export CLUSTER_VENDOR=IBM
export CLUSTER_NAME=icp-local-2
export CLUSTER_ENV=Dev
export CLUSTER_REGION=EU \
export CLUSTER_DATACENTER=geneva \
export CLUSTER_OWNER=IT
export HUB_IP=https://9.30.119.132:8001
HUB_TOKEN=replace

# INSTALL

kubectl create namespace mcm-namespace
kubectl create secret tls klusterlet-tiller-secret --cert ~/.helm/cert.pem --key ~/.helm/key.pem -n kube-system


helm install ~/INSTALL/APPS/mcmk/klusterlet/ibm-mcmk-prod \
--name mcmk \
--namespace kube-system \
--set topology.enabled=true \
--set klusterlet.tillersecret=klusterlet-tiller-secret \
--set klusterlet.clusterName=$CLUSTER_NAME \
--set klusterlet.clusterNamespace=mcm-$CLUSTER_NAME \
--set klusterlet.apiserverConfig.server=$HUB_IP \
--set klusterlet.apiserverConfig.token=$HUB_TOKEN \
--set klusterlet.pullPolicy=IfNotPresent \
--set klusterlet.cloud=$CLUSTER_CLOUD \
--set klusterlet.vendor=$CLUSTER_VENDOR \
--set klusterlet.environment=$CLUSTER_ENV \
--set klusterlet.region=$CLUSTER_REGION \
--set klusterlet.datacenter=$CLUSTER_DATACENTER \
--set klusterlet.owner=$CLUSTER_OWNER \
--set registry=mycluster.icp:8500/kube-system/ \
--tls



-------------------------------------------------
------------------------------------------------


helm install ~/INSTALL/APPS/mcmk/klusterlet/ibm-mcmk-prod \
--name mcmk \
--namespace kube-system \
--set topology.enabled=true \
--set klusterlet.tillersecret=klusterlet-tiller-secret \
--set klusterlet.clusterName=$CLUSTER_NAME \
--set klusterlet.clusterNamespace=mcm-$CLUSTER_NAME \
--set klusterlet.apiserverConfig.server=$HUB_IP \
--set klusterlet.apiserverConfig.token=$HUB_TOKEN \
--set klusterlet.pullPolicy=IfNotPresent \
--set klusterlet.cloud=$CLUSTER_CLOUD \
--set klusterlet.vendor=$CLUSTER_VENDOR \
--set klusterlet.environment=$CLUSTER_ENV \
--set klusterlet.region=$CLUSTER_REGION \
--set klusterlet.datacenter=$CLUSTER_DATACENTER \
--set klusterlet.owner=$CLUSTER_OWNER \
--set registry= registry.eu-de.bluemix.net/niklaushirt/ \
--tls










export CLUSTER_CLOUD=ICP
export CLUSTER_VENDOR=IBM
export CLUSTER_NAME=minikube-1
export CLUSTER_ENV=Dev
export CLUSTER_REGION=EU \
export CLUSTER_DATACENTER=geneva \
export CLUSTER_OWNER=IT
export HUB_IP=https://9.30.119.132:8001
export HUB_TOKEN=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdF9oYXNoIjoiZGJwZWI2ZzBrcW0wNGFmbm93cmkiLCJyZWFsbU5hbWUiOiJjdXN0b21SZWFsbSIsInVuaXF1ZVNlY3VyaXR5TmFtZSI6ImFkbWluIiwiaXNzIjoiaHR0cHM6Ly9teWNsdXN0ZXIuaWNwOjk0NDMvb2lkYy9lbmRwb2ludC9PUCIsImF1ZCI6ImI0NDQ4ODQwNDliZDRmOTgxNmIyZTQ4ZDNiODg3NmQxIiwiZXhwIjoxNTQ0NzM2NjI5LCJpYXQiOjE1NDQ3MDc4MjksInN1YiI6ImFkbWluIiwidGVhbVJvbGVNYXBwaW5ncyI6W119.wYsbNybUpZ7ETMF0K-TpryyHdj72mYi4qUplZqfXIA1U5gAq8xPiAGO8Vm4msGim5cZ9BUBr9--iUDZCk5r7hRW5ZB9YjuOe581ApBU8U6S9LQzYnuePLLNjy3EXBQ82jnlvCUp9X5JpHGWWViU5d51niapSr9udBJz0g-qbHptMCd8DbOAu_OZjTSNKtyG8XGwUSIRbcbwXFzKY2A50OwgyWYofrD3zpWjklif4_mIdMJy9S6pS5vwmlioulwZ1xXvA_2bsXYXm4zBKBegUWDYS2cvaWAipeJCNbI7YC5LIgAAl0A2rd5jiamOeH9tXMAsNw0z_71diLYPS2UK9Fg



helm install ibm-mcmk-prod \
--name mcmk \
--namespace kube-system \
--set topology.enabled=true \
--set klusterlet.tillersecret=klusterlet-tiller-secret \
--set klusterlet.clusterName=$CLUSTER_NAME \
--set klusterlet.clusterNamespace=mcm-$CLUSTER_NAME \
--set klusterlet.apiserverConfig.server=$HUB_IP \
--set klusterlet.apiserverConfig.token=$HUB_TOKEN \
--set klusterlet.pullPolicy=IfNotPresent \
--set klusterlet.cloud=$CLUSTER_CLOUD \
--set klusterlet.vendor=$CLUSTER_VENDOR \
--set klusterlet.environment=$CLUSTER_ENV \
--set klusterlet.region=$CLUSTER_REGION \
--set klusterlet.datacenter=$CLUSTER_DATACENTER \
--set klusterlet.owner=$CLUSTER_OWNER \
--set registry= registry.eu-de.bluemix.net/niklaushirt/



helm template ibm-mcmk-prod \
--name mcmk \
--namespace kube-system \
--set topology.enabled=true \
--set klusterlet.tillersecret=klusterlet-tiller-secret \
--set klusterlet.clusterName=$CLUSTER_NAME \
--set klusterlet.clusterNamespace=mcm-$CLUSTER_NAME \
--set klusterlet.apiserverConfig.server=$HUB_IP \
--set klusterlet.apiserverConfig.token=$HUB_TOKEN \
--set klusterlet.pullPolicy=IfNotPresent \
--set klusterlet.cloud=$CLUSTER_CLOUD \
--set klusterlet.vendor=$CLUSTER_VENDOR \
--set klusterlet.environment=$CLUSTER_ENV \
--set klusterlet.region=$CLUSTER_REGION \
--set klusterlet.datacenter=$CLUSTER_DATACENTER \
--set klusterlet.owner=$CLUSTER_OWNER \
--set registry= registry.eu-de.bluemix.net/niklaushirt/ > install.yaml








mcm-compliance:3.1.1
mcm-klusterlet:3.1.1
icp-router:2.2.0
mcm-weave-scope:3.1.1


docker pull mycluster.icp:8500/kube-system/mcm-compliance:3.1.1
docker pull mycluster.icp:8500/kube-system/mcm-klusterlet:3.1.1
docker pull mycluster.icp:8500/kube-system/icp-router:2.2.0
docker pull mycluster.icp:8500/kube-system/mcm-weave-scope:3.1.1


docker tag mycluster.icp:8500/kube-system/mcm-compliance:3.1.1 registry.eu-de.bluemix.net/niklaushirt/mcm-compliance:3.1.1
docker tag mycluster.icp:8500/kube-system/mcm-klusterlet:3.1.1 registry.eu-de.bluemix.net/niklaushirt/mcm-klusterlet:3.1.1
docker tag mycluster.icp:8500/kube-system/icp-router:2.2.0 registry.eu-de.bluemix.net/niklaushirt/icp-router:2.2.0
docker tag mycluster.icp:8500/kube-system/mcm-weave-scope:3.1.1 registry.eu-de.bluemix.net/niklaushirt/mcm-weave-scope:3.1.1


docker push registry.eu-de.bluemix.net/niklaushirt/mcm-compliance:3.1.1
docker push registry.eu-de.bluemix.net/niklaushirt/mcm-klusterlet:3.1.1
docker push registry.eu-de.bluemix.net/niklaushirt/icp-router:2.2.0
docker push registry.eu-de.bluemix.net/niklaushirt/mcm-weave-scope:3.1.1

docker login registry.eu-de.bluemix.net/niklaushirt -u token dR6HpPn4FI

docker pull registry.eu-de.bluemix.net/niklaushirt/mcm-compliance:3.1.
docker push registry.eu-de.bluemix.net/niklaushirt/mcm-klusterlet:3.1.1
docker push registry.eu-de.bluemix.net/niklaushirt/icp-router:2.2.0
docker push registry.eu-de.bluemix.net/niklaushirt/mcm-weave-scope:3.1.1



docker push registry.eu-de.bluemix.net/niklaushirt/<my_repository>:<my_tag>



ibmcloud login --sso
ibmcloud cs region-set eu-central
ibmcloud cs cluster-config mycluster
ibmcloud cs cluster-config mykube


kubectl delete -f install.yaml -n kube-system
kubectl create -f install.yaml --validate=false -n kube-system


docker tag registry.eu-de.bluemix.net/niklaushirt/mcm-compliance:3.1. registry.eu-de.bluemix.net/niklaushirt/mcm-compliance:3.1.1
