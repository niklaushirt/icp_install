#!/bin/bash

source ~/INSTALL/0_variables.sh


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Prerequisites";

wget dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
rpm -ihv epel-release-7-11.noarch.rpm

# Install docker & python on master
sudo yum install -y yum-utils device-mapper-persistent-data lvm2


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Docker"
# INSTALL DOCKER
#snap install docker

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum -y install docker-ce
sudo systemctl start docker
sudo usermod -a -G docker icp

#sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#sudo apt-get --yes --force-yes update
#sudo apt-get install --yes docker-ce=17.09.0~ce-0~ubuntu


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Python"
sudo yum install -y python-setuptools
sudo easy_install pip


# Install Command Line Tools
echo "Installing Tools";
sudo yum install wget
wget dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
sudo rpm -ihv epel-release-7-11.noarch.rpm

sudo yum install -y tree
sudo yum install -y  htop
sudo yum install -y  curl
sudo yum install -y  unzip
sudo yum install -y  iftop


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Adapt Environment"
# Set VM max map count (see max_map_count https://www.kernel.org/doc/Documentation/sysctl/vm.txt)
sudo sysctl -w vm.max_map_count=262144

sudo cat <<EOB >>/etc/sysctl.conf
vm.max_map_count=262144
EOB

# Sync time
sudo ntpdate -s time.nist.gov


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Configure Firewall"
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo systemctl mask --now firewalld





echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"

for ((i=0; i < $NUM_WORKERS; i++)); do
  if [[ $WORKER_IPS[i] != "n" ||  $MASTER_IP == "N" ]]; then
    echo "-----------------------------------------------------------------------------------------------------------"
    echo "-----------------------------------------------------------------------------------------------------------"
    echo "INSTALLING WORKER NODE ON $WORKER_IPS[i]"
    echo "-----------------------------------------------------------------------------------------------------------"
    echo "-----------------------------------------------------------------------------------------------------------"
    cat ~/INSTALL/KUBE/REMOTE_PREPARE/preInstallRemote.sh | ssh root@${WORKER_IPS[i]} 'bash -s'
  fi
done

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"

if [ "$MONITORING_IP" != "x.x.x.x" ]; then
    echo "-----------------------------------------------------------------------------------------------------------"
    echo "-----------------------------------------------------------------------------------------------------------"
    echo "INSTALLING MONITORING ON $MONITORING_IP"
    echo "-----------------------------------------------------------------------------------------------------------"
    echo "-----------------------------------------------------------------------------------------------------------"
    cat ~/INSTALL/KUBE/REMOTE_PREPARE/preInstallRemote.sh | ssh root@${MONITORING_IP} 'bash -s'
else
  echo "-----------------------------------------------------------------------------------------------------------"
  echo "-----------------------------------------------------------------------------------------------------------"
  echo "NO MONITORING DEFINED"
  echo "-----------------------------------------------------------------------------------------------------------"
  echo "-----------------------------------------------------------------------------------------------------------"
fi










echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "INSTALL INCEPTION"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"



#echo "Creating SSH Key";
#ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa -N ""
#cat ~/.ssh/id_rsa.pub | sudo tee -a ~/.ssh/authorized_keys
#ssh-copy-id -i ~/.ssh/id_rsa.pub root@

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Fetch Docker Inception Image"
#sudo docker pull ibmcom/icp-inception:${ICP_VERSION}


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Creating Cluster Directory";
cd ~/INSTALL
sudo docker run -e LICENSE=accept -v "$(pwd)":/data ibmcom/icp-inception:${ICP_VERSION} cp -r cluster /data


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Adapting Config";

# Configure hosts
echo "[master]" | sudo tee ~/INSTALL/cluster/hosts
echo "${MASTER_IP}" | sudo tee -a ~/INSTALL/cluster/hosts
echo "" | sudo tee -a ~/INSTALL/cluster/hosts

echo "[worker]" | sudo tee -a ~/INSTALL/cluster/hosts
for ((i=0; i < $NUM_WORKERS; i++)); do
  echo ${WORKER_IPS[i]} | sudo tee -a ~/INSTALL/cluster/hosts
done
echo "" | sudo tee -a ~/INSTALL/cluster/hosts

echo "[proxy]" | sudo tee -a ~/INSTALL/cluster/hosts
echo "${MASTER_IP}" | sudo tee -a ~/INSTALL/cluster/hosts
echo "" | sudo tee -a ~/INSTALL/cluster/hosts



if [ "$MONITORING_IP" != "x.x.x.x" ]; then
  echo "[management]" | sudo tee -a ~/INSTALL/cluster/hosts
  echo "${MONITORING_IP}" | sudo tee -a ~/INSTALL/cluster/hosts
else
  echo "No separate monitoring/management node"
fi

ne for external IP in config
echo "cluster_access_ip: ${PUBLIC_IP}" | sudo tee -a ~/INSTALL/cluster/config.yaml
echo "proxy_access_ip: ${PUBLIC_IP}" | sudo tee -a ~/INSTALL/cluster/config.yaml
echo 'kubelet_extra_args: ["--max-pods=300 --pods-per-core=70"]' | sudo tee -a ~/INSTALL/cluster/config.yaml
echo 'default_admin_password: admin' | sudo tee -a ~/INSTALL/cluster/config.yaml
echo 'password_rules:' | sudo tee -a ~/INSTALL/cluster/config.yaml
echo " - '(.*)'" | sudo tee -a ~/INSTALL/cluster/config.yaml
echo 'single_cluster_mode: false' | sudo tee -a ~/INSTALL/cluster/config.yaml
echo 'loopback_dns: true' | sudo tee -a ~/INSTALL/cluster/config.yaml


nano ~/INSTALL/cluster/config.yaml

management_services:
  istio: disabled
  vulnerability-advisor: disabled
  storage-glusterfs: disabled
  storage-minio: disabled
  platform-security-netpols: disabled
  node-problem-detector-draino: disabled
  knative: disabled
  multicluster-hub: enabled






echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Copy SSH Key";
echo "there might be an error, but should be ok";
sudo cp ~/.ssh/id_rsa ~/INSTALL/cluster/ssh_key
sudo cp ~/.ssh/master.id_rsa ~/INSTALL/cluster/ssh_key
sudo chmod 400 ~/INSTALL/cluster/ssh_key
