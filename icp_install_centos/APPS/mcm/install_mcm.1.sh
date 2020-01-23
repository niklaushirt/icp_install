#!/bin/bash
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Multi Cloud manager";
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"


source ~/INSTALL/0_variables.sh

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Create Resources (namespaces, Secrets, ...)";
# CREATE RESSOURCES
kubectl create namespace mcm-namespace
kubectl create secret tls klusterlet-tiller-secret --cert ~/.helm/cert.pem --key ~/.helm/key.pem -n kube-system
#export CLUSTER_IP=$PUBLIC_IP
#kubectl patch daemonset catalog-ui --patch '{"spec": {"template":{"spec":{"containers":[{"name":"catalog-ui","env":[{"name":"hcmCapabilityEnabled","value":"true"},{"name":"hcmRedirectUrl","value":"https://'${CLUSTER_IP}':8443/hcmconsole/remoteinstall"}]}]}}}}' -n kube-system




echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing command line";
# INSTALL COMMAND LINE
docker run -e LICENSE=accept -v $(pwd):/data mycluster.icp:8500/kube-system/mcmctl:3.1.2 cp mcmctl-linux-amd64 /data/mcmctl
docker run -e LICENSE=accept -v $(pwd):/data mycluster.icp:8500/kube-system/mcmctl:3.1.2 cp mcmctl-linux-amd64 /data/mcmctl

sudo cp mcmctl /usr/local/bin/



echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Load Helm charts locally";

cd charts



helm install  ~/INSTALL/APPS/mcm/ibm-mcm-dev \
--name mcm \
--namespace kube-system \
--set compliance.mcmNamespace=mcm-namespace > ~/INSTALL/APPS/mcm/install/mcm_install.yaml



helm template ~/INSTALL/APPS/mcm/ibm-mcm-dev \
--name mcm \
--namespace kube-system \
--set compliance.mcmNamespace=mcm-namespace > ~/INSTALL/APPS/mcm/install/mcm_install.yaml



kubectl apply -n kube-system -f ~/INSTALL/APPS/mcm/install/mcm_install.yaml
kubectl delete -n kube-system -f ~/INSTALL/APPS/mcm/install/mcm_install.yaml



console.mcmui.image.repository
apiserver.repository
controller.repository


  --set klusterlet.tillersecret=lusterlet-tiller-secret
  --set klusterlet.tillersecret=klusterlet_tiller_secret
  --set klusterlet.clusterName=cluster.local
  --set klusterlet.clusterNamespace=cluster-namespace
  --set klusterlet.environment=PROD
  --set klusterlet.region=EUROPE
  --set klusterlet.datacenter=Geneva
  --set klusterlet.owner=IT
  helm install ~/INSTALL/APPS/mcm/install/charts/ibm-mcm-klusterlet-3.1.1.tgz --name mcm-klusterlet --namespace kube-system --set klusterlet.tillersecret=lusterlet-tiller-secret --set klusterlet.tillersecret=klusterlet_tiller_secret --set klusterlet.clusterName=cluster.local --set klusterlet.clusterNamespace=cluster-namespace --set klusterlet.environment=PROD --set klusterlet.region=EUROPE --set klusterlet.datacenter=Geneva --set klusterlet.owner=IT


read -p "Install and configure Guestbook? [y,N]" DO_CHC
if [[ $DO_CHC == "y" ||  $DO_CHC == "Y" ]]; then
  echo "-----------------------------------------------------------------------------------------------------------"
  echo "-----------------------------------------------------------------------------------------------------------"
  echo "Install Demo App: Guestbook";
  cloudctl login -a https://mycluster.icp:8443 --skip-ssl-validation -u admin -p admin -n default  -c id-mycluster-account

  helm package demos/guestbook/gbapp
  cloudctl catalog load-chart --archive gbapp-0.1.0.tgz
  helm install --name gbapp --namespace default local/gbapp --tls
fi



read -p "Install and configure Trader? [y,N]" DO_CHC
if [[ $DO_CHC == "y" ||  $DO_CHC == "Y" ]]; then
  echo "-----------------------------------------------------------------------------------------------------------"
  echo "-----------------------------------------------------------------------------------------------------------"
  echo "Install Demo App: Trader";
  cd ~/INSTALL/APPS/mcm/demo/demos/trader/helm
  mcmctl create -f helmrepo.yaml --cluster-namespace default
  mcmctl create -Rf traderapp/ --cluster-namespace default
fi
