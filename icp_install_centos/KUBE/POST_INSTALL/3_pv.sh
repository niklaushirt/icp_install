#!/bin/bash

source ~/INSTALL/0_variables.sh

# Create PersistentVolumes
echo "Install NFS Server"
if [  -n "$(uname -a | grep Ubuntu)" ]; then
  #sudo apt-get --yes --force-yes install nfs-kernel-server
  sudo apt-get --yes install nfs-kernel-server
else
  wget dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
  sudo yum -y install nfs-utils
  sudo yum -y install nfs-utils-lib
  sudo systemctl start rpcbind
  sudo systemctl start nfs-server
  sudo systemctl start nfs-lock
  sudo systemctl start nfs-idmap
  sudo systemctl start nfs
fi
# Create NFS Directories
echo "Create NFS Directories"
sudo mkdir -p /storage/
sudo mkdir -p /storage/nfsvol01rwo
sudo mkdir -p /storage/nfsvol02rwm
sudo mkdir -p /storage/nfsvol03rwo
sudo mkdir -p /storage/nfsvol04rwm
sudo mkdir -p /storage/nfsvol05rwo
sudo mkdir -p /storage/nfsvol06rwm
sudo mkdir -p /storage/nfsvol07rwo
sudo mkdir -p /storage/nfsvol08rwm
sudo mkdir -p /storage/nfsvol11rwo
sudo mkdir -p /storage/nfsvol12rwo
sudo mkdir -p /storage/nfsvol13rwo
sudo mkdir -p /storage/nfsvol14rwo
sudo mkdir -p /storage/nfsvol15rwo
sudo mkdir -p /storage/nfsvol16rwo
sudo mkdir -p /storage/nfsvol17rwo
sudo mkdir -p /storage/nfsvol18rwo
sudo mkdir -p /storage/dsx
sudo mkdir -p /storage/TRA_data
sudo mkdir -p /storage/data-stor
sudo mkdir -p /storage/hadr-stor
sudo mkdir -p /storage/etcd-stor
sudo mkdir -p /storage/pv0001
sudo mkdir -p /storage/pv0002
sudo mkdir -p /storage/CAM_db
sudo mkdir -p /storage/CAM_logs
sudo mkdir -p /storage/CAM_terraform
sudo mkdir -p /storage/CAM_bpd

sudo chmod -R 777 /storage

# Configure NFS
echo "Configure NFS"
echo "/storage           *(rw,sync,no_subtree_check,async,insecure,no_root_squash)" | sudo tee -a /etc/exports

sudo exportfs -a


if [  -n "$(uname -a | grep Ubuntu)" ]; then
  sudo chown -R nobody:nogroup /storage
  sudo systemctl restart nfs-kernel-server
else
  sudo systemctl restart nfs
fi

# Create PersistentVolumes
echo "Create PersistentVolumes"
kubectl apply -f ~/INSTALL/KUBE/PV/pv.yaml

# Create NFS Dynamic provisioner
kubectl apply -f ~/INSTALL/KUBE/PV/clusterimagepolicynfs.yaml
helm repo update
helm install --name nfs-dynamic --set podSecurityPolicy.enabled=true --set nfs.server=$MASTER_IP --set nfs.path=/storage stable/nfs-client-provisioner --tls
