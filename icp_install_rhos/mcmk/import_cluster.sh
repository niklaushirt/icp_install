#!/bin/bash




source ~/INSTALL/0_variables.sh

#----------------------------------------------------------------------------------------------
# Configuration - Adapt to target
#----------------------------------------------------------------------------------------------
# Use local-cluster for HUB
#----------------------------------------------------------------------------------------------
export HUB_IP=9.30.248.180:8443
export CLUSTER_NAME=icp-fyre-mcm
export CLUSTER_NAMESPACE=mcm-$CLUSTER_NAME

export CLUSTER_CLOUD=ICP
export CLUSTER_VENDOR=IBM
export CLUSTER_ENV=Prod
export CLUSTER_REGION=US 
export CLUSTER_DATACENTER=dallas 
export CLUSTER_OWNER=IT


#----------------------------------------------------------------------------------------------
# Create target kubeconfig
#----------------------------------------------------------------------------------------------
export KUBECONFIG=kubeconfig
<COPY PASTE TARGET CLUSTER from Configure Client Web Interface>
unset KUBECONFIG

#----------------------------------------------------------------------------------------------
# Login to HUB
#----------------------------------------------------------------------------------------------
cloudctl login -a https://$HUB_IP --skip-ssl-validation -u admin -p admin -n kube-system


#----------------------------------------------------------------------------------------------
# Create cluster-import File
#----------------------------------------------------------------------------------------------
cloudctl mc cluster template $CLUSTER_NAME -n $CLUSTER_NAMESPACE > cluster-import.yaml

sed -i "s/environment: \"Dev\"/environment: \"$CLUSTER_ENV\"/" cluster-import.yaml
sed -i "s/region: \"US\"/region: \"$CLUSTER_REGION\"/g" cluster-import.yaml
sed -i "s/datacenter: \"us-east\"/datacenter: \"$CLUSTER_DATACENTER\"/g" cluster-import.yaml
sed -i "s/owner: \"owner\"/owner: \"$CLUSTER_OWNER\"/g" cluster-import.yaml

cat cluster-import.yaml

#----------------------------------------------------------------------------------------------
# Import Cluster
#----------------------------------------------------------------------------------------------
cloudctl mc cluster import -f cluster-import.yaml --cluster-kubeconfig kubeconfig --cluster-context mycluster-context  

#----------------------------------------------------------------------------------------------
# Remove Cluster
#----------------------------------------------------------------------------------------------
#cloudctl mc cluster remove local-cluster --cluster-kubeconfig kubeconfig --cluster-context mycluster-context --namespace mcm-local-cluster


