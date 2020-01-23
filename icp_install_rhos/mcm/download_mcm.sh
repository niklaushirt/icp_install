#!/bin/bash
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Multi Cloud manager";
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"


source ~/INSTALL/0_variables.sh


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Get Demo Stuff";
cd ~/INSTALL/APPS/mcm
git clone https://github.ibm.com/claudio-tag/MCMdemo.git demo


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "get PPA";
# UPLOAD PPA
mkdir -p ~/INSTALL/APPS/mcm/install
cd ~/INSTALL/APPS/mcm/install
#scp mcm-3.1.1-amd64.tgz icp@icp:/home/icp/INSTALL/APPS/mcm/install
wget https://ibm.box.com/shared/static/5l6a7w5gjqa94239fwlidyrx44vf64u8.tgz -O mcm-ppa-3.1.2.tgz

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Upload assets to cluster";
# UPLOAD DOCKER IMAGES
docker login mycluster.icp:8500 -u admin -p admin
cloudctl login -a https://mycluster.icp:8443 --skip-ssl-validation -u admin -p admin -n kube-system  -c id-mycluster-account

cloudctl catalog load-ppa-archive -a ~/INSTALL/APPS/mcm/install/mcm-ppa-3.1.2.tgz --registry mycluster.icp:8500
