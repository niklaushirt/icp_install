#!/bin/bash

source ~/INSTALL/0_variables.sh

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
  echo "Installing Command Line Tools";
  # Install Command Line Tools

  echo "Installing kubectl";
  curl -kLo kubectl-linux-amd64-v1.13.5 https://$MASTER_IP:8443/api/cli/kubectl-linux-amd64


  echo "Installing IBMCLOUD Command Line & Plugin";
  curl -kLo cloudctl-linux-amd64-v3.2.0-634 https://$MASTER_IP:8443/api/cli/cloudctl-linux-amd64

  #sudo cloudctl login -a https://${MASTER_IP}:8443 --skip-ssl-validation
  cloudctl login -a https://mycluster.icp:8443 --skip-ssl-validation -u admin -p admin -n kube-system  -c id-mycluster-account

  #sudo cloudctl clusters
  #sudo cloudctl cluster-config mycluster

  echo "Installing helm";
  #Install HELM CLI
  curl -kLo helm-linux-amd64-v2.12.3.tar.gz https://$MASTER_IP:8443/api/cli/helm-linux-amd64.tar.gz

  echo "Installing istio ctl";
  curl -kLo istioctl-linux-amd64-v1.0.2 https://$MASTER_IP:8443/api/cli/istioctl-linux-amd64

  echo "Installing calico ctl";
  curl -kLo calicoctl-linux-amd64-v3.3.1 https://$MASTER_IP:8443/api/cli/calicoctl-linux-amd64

  echo "Configuring helm";
  sudo helm init --client-only
  sudo cp /root/.helm/cert.pem ~/.helm/
  sudo cp /root/.helm/key.pem ~/.helm/
  sudo  helm version --tls

  sudo chown -R icp:icp ~/.kube/
  sudo chown -R icp:icp ~/.helm/
  sudo chown -R icp:icp ~/.cloudctl/
