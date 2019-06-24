#!/bin/bash

source ~/INSTALL/0_variables.sh

cat ~/INSTALL/KUBE/CONFIG/bashrc.sh >> ~/.bashrc


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure Demo Stuff? [y,N]" DO_STF
if [[ $DO_STF == "y" ||  $DO_STF == "Y" ]]; then
  ~/INSTALL/KUBE/POST_INSTALL/6_demo_assets.sh
else
  echo "Stuff not configured"
fi


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure Command Line Tools? [y,N]" DO_COMM
if [[ $DO_COMM == "y" ||  $DO_COMM == "Y" ]]; then
  ~/INSTALL/KUBE/POST_INSTALL/1_command_line.sh
else
  echo "Command Line Tools not configured"
fi



echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing kube config";
#INIT KUBECTL
mkdir ~/.kube
cp /var/lib/kubelet/kubectl-config ~/.kube/config


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure OpenLDAP? [y,N]" DO_LDAP
if [[ $DO_LDAP == "y" ||  $DO_LDAP == "Y" ]]; then
  ~/INSTALL/KUBE/POST_INSTALL/2_ldap.sh
else
  echo "LDAP not configured"
fi


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
read -p "Install and configure PersistentVolumes? [y,N]" DO_PV
if [[ $DO_PV == "y" ||  $DO_PV == "Y" ]]; then
  ~/INSTALL/KUBE/POST_INSTALL/3_pv.sh
else
  echo "PersistentVolumes not configured"
fi




echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "ALL DONE"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Add Repositories"
echo "-----------------------------------------------------------------------------------------------------------"
echo "DEMO"
echo "https://raw.githubusercontent.com/niklaushirt/charts/master/helm/charts/repo/stable/"
echo ""
echo "Kubernetes"
echo "https://kubernetes-charts.storage.googleapis.com/"
echo ""
echo "Guestbook"
echo "https://raw.githubusercontent.com/niklaushirt/guestbook/master/helm/repo/stable/"
echo ""

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Please execute 'source ~/.bashrc'"
echo "Add Grafana Dashboards: 8670 and 8673"
echo "                 https://grafana.com/dashboards/8670"
echo "                 https://grafana.com/dashboards/8673"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
