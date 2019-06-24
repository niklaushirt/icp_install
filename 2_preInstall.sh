#!/bin/bash

source ~/INSTALL/0_variables.sh

echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Prerequisites";

if [  -n "$(uname -a | grep Ubuntu)" ]; then
  sudo apt-get  --yes --force-yes install snapd apt-transport-https ca-certificates curl software-properties-common python-minimal
else
  wget dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
  rpm -ihv epel-release-7-11.noarch.rpm
  sudo yum install -y yum-utils device-mapper-persistent-data lvm2
fi



echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Installing Docker"
# INSTALL DOCKER

if [  -n "$(uname -a | grep Ubuntu)" ]; then
  sudo apt-get install \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"
  sudo apt-get update
  sudo apt-get install docker-ce=18.03.1~ce-0~ubuntu
else
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum makecache fast
  sudo yum -y install docker-ce
  sudo systemctl start docker
fi



if [  -n "$(uname -a | grep Ubuntu)" ]; then
  echo "-----------------------------------------------------------------------------------------------------------"
  echo "-----------------------------------------------------------------------------------------------------------"
  echo "Disable AppArmor"
  # Disable AppArmor
  sudo aa-status
  sudo systemctl disable apparmor.service --now
  sudo service apparmor teardown
else
  echo "-----------------------------------------------------------------------------------------------------------"
  echo "-----------------------------------------------------------------------------------------------------------"
  echo "Installing Python"
  sudo yum install -y python-setuptools
  sudo easy_install pip
fi





# Install Command Line Tools
echo "Installing Tools";

if [  -n "$(uname -a | grep Ubuntu)" ]; then
  sudo apt-get --yes --force-yes install tree
  sudo apt-get --yes --force-yes install htop
  sudo apt-get --yes --force-yes install curl
  sudo apt-get --yes --force-yes install unzip
  sudo apt-get --yes --force-yes install iftop
else
  sudo yum install -y tree
  sudo yum install -y  htop
  sudo yum install -y  curl
  sudo yum install -y  unzip
  sudo yum install -y  iftop
fi


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
sudo ufw disable









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

# Add line for external IP in config
echo "cluster_access_ip: ${PUBLIC_IP}" | sudo tee -a ~/INSTALL/cluster/config.yaml
echo "proxy_access_ip: ${PUBLIC_IP}" | sudo tee -a ~/INSTALL/cluster/config.yaml
echo 'kubelet_extra_args: ["--max-pods=300 --pods-per-core=70"]' | sudo tee -a ~/INSTALL/cluster/config.yaml
echo 'default_admin_password: admin' | sudo tee -a ~/INSTALL/cluster/config.yaml
echo 'password_rules:' | sudo tee -a ~/INSTALL/cluster/config.yaml
echo " - '(.*)'" | sudo tee -a ~/INSTALL/cluster/config.yaml


echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Copy SSH Key";
echo "there might be an error, but should be ok";
sudo cp ~/.ssh/id_rsa ~/INSTALL/cluster/ssh_key
sudo cp ~/.ssh/master.id_rsa ~/INSTALL/cluster/ssh_key
sudo chmod 400 ~/INSTALL/cluster/ssh_key
