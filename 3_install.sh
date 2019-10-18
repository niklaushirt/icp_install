#!/bin/bash

source ~/INSTALL/0_variables.sh


echo "Installing ICP CE";
cd ~/INSTALL/cluster
sudo docker run --net=host -t -e LICENSE=accept -v "$(pwd)":/installer/cluster ibmcom/icp-inception:${ICP_VERSION} install


#sudo docker run --net=host -t -e LICENSE=accept -v "$(pwd)":/installer/cluster ibmcom/icp-inception:${ICP_VERSION} uninstall
