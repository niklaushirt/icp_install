#!/bin/bash

VBoxManage modifyvm CoreOS_Desktop --nested-hw-virt on
VBoxManage modifyvm RHEL8 --nested-hw-virt on

VBoxManage setextradata global GUI/HidLedsSync 0
git clone https://github.com/niklaushirt/rhos_install.git INSTALL


echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo " CHECK SELINUX and firewall"
echo ""
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"

more /etc/selinux/config
sestatus
getenforce


getenforce | grep "Permissive" 
if [ $? -eq 1 ]; then
    echo "SELinux not set to Permissive"
    read -rp "Do you want to fix this? (automatic reboot required)   y/N" choice;
	if [ "$choice" == "Y" ] ; then
        echo "Fixing things"
        sed -i "s/SELINUX=enforcing/SELINUX=permissive/" /etc/selinux/config
        sed -i "s/SELINUX=disabled/SELINUX=permissive/" /etc/selinux/config
        reboot
    fi
fi

sudo firewall-cmd --state
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo systemctl mask --now firewalld




echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo " PREPARATION"
echo ""
echo " https://docs.okd.io/latest/install/host_preparation.html"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"


export DOMAIN=${DOMAIN:="$(curl -s ipinfo.io/ip).nip.io"}
export USERNAME=${USERNAME:="$(whoami)"}
export PASSWORD=${PASSWORD:=password}
export VERSION=${VERSION:="3.11"}
export IP=${IP:="$(ip route get 8.8.8.8 | awk '{print $7}')"}
export API_PORT=${API_PORT:="8443"}
export DOMAIN="$IP.nip.io"

echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "Your configuration"
echo "IP: $IP"
echo "API_PORT: $API_PORT"
echo "DOMAIN: $DOMAIN"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"




echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "Install tools"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"

echo "Install EPEL"
yum -y install epel-release

echo "Install Tools"
sudo yum install -y tree htop unzip iftop net-data pyOpenSSL wget git nano net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct openssl-devel httpd-tools NetworkManager python-cryptography python2-pip python-devel python-passlib java-1.8.0-openjdk-headless -y

#sudo yum --disablerepo="*" --enablerepo="epel" install htop
#sudo yum --disablerepo="*" --enablerepo="epel" install net-data


echo "-------------------------------------------------------------------------------------------"
echo "Install k9s"
echo "-------------------------------------------------------------------------------------------"
wget https://github.com/derailed/k9s/releases/download/0.8.4/k9s_0.8.4_Linux_x86_64.tar.gz
tar -zxvf k9s_0.8.4_Linux_x86_64.tar.gz
chmod +x k9s
sudo mv k9s /usr/local/bin/
sudo rm k9s_0.8.4_Linux_x86_64.tar.gz


echo "-------------------------------------------------------------------------------------------"
echo "Install ansible"
echo "-------------------------------------------------------------------------------------------"
curl -o ansible.rpm https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/ansible-2.6.5-1.el7.ans.noarch.rpm
sudo yum -y install ansible.rpm
sudo rm ansible.rpm


echo "-------------------------------------------------------------------------------------------"
echo "Install Docker"
echo "-------------------------------------------------------------------------------------------"

sudo yum install docker-1.13.1 -y
rpm -V docker-1.13.1

sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl is-active docker
docker version
sudo groupadd docker
sudo usermod -aG docker $USER





echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "Adapt Environment"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
# Set VM max map count (see max_map_count https://www.kernel.org/doc/Documentation/sysctl/vm.txt)
sudo sysctl -w vm.max_map_count=262144

echo "Check max_map_count"

if ! grep -q vm.max_map_count=262144 /etc/sysctl.conf; then
  echo "Add max_map_count"
  sudo cat <<EOB >>/etc/sysctl.conf
  vm.max_map_count=262144
EOB
fi
more /etc/sysctl.conf




echo "Check DNS"

echo "IP: $IP"
echo "DOMAIN: $DOMAIN"

cat <<EOD >> /etc/hosts
${IP}   $(hostname) console console.${DOMAIN}  
EOD
more /etc/hosts



echo "Check bashrc"

if ! grep -q KUBE_EDITOR= ~/.bashrc; then
  echo "Add tools to bashrc" 

  sudo cat <<EOB >>~/.bashrc
    KUBE_EDITOR="nano" 

    alias clusterstatus='sudo watch -n 5 "docker ps -a -n15 --format \"table {{.RunningFor}}\\t{{.Status}}\\t{{.Command}}\\t{{.Names}}\" | cut -c -140"'
    alias klogin='oc login -u root https://localhost:8443'
    alias gitrefresh='git checkout origin/master -f | git checkout master -f | git pull origin master'
    alias kns='echo "kubectl config set-context mycluster-context --user=admin --namespace="'
    alias hlist='helm list -d -r --tls'
    alias hkill='helm delete --tls --purge '
    alias kstatus='sudo watch -n 5 "docker ps -a -n15 --format \"table {{.RunningFor}}\\t{{.Status}}\\t{{.Command}}\\t{{.Names}}\" | cut -c -140"'
    alias pkill='kubectl delete pod --force --grace-period 0 '
    alias plist='kubectl get pods --sort-by='{.metadata.creationTimestamp}' -o wide'
    alias pinspect='kubectl get pod -o yaml '
    alias plog='kubectl logs '
    alias pdesc='kubectl describe pod '
    alias dsearch='docker ps | grep '
    alias dlist='docker ps -n15 --format "table {{.RunningFor}}\\t{{.Status}}\\t{{.Command}}\\t{{.Names}}" | cut -c -140'
    alias dlistall='docker ps -n15 -a --format "table {{.RunningFor}}\\t{{.Status}}\\t{{.Command}}\\t{{.Names}}" | cut -c -140'
    alias dlog='docker logs '
    alias ..='cd ..'
    ## Colorize the ls output ##
    alias ls='ls --color=auto'
    alias edit_placement='KUBE_EDITOR="nano" kubectl edit pp --namespace default'
    alias netwrk='nmtui'
EOB

fi

more ~/.bashrc



echo "Check DNS"

if ! grep -q DNS1= /etc/sysconfig/network-scripts/ifcfg-eth0; then
  echo "Add DNS"
  sudo echo "DNS1=8.8.8.8" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
  sudo echo "DNS2=8.8.4.4" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
fi
more /etc/sysconfig/network-scripts/ifcfg-eth0






echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo " INSTALL"
echo ""
echo " https://docs.okd.io/latest/install/host_preparation.html"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"

echo "Clone Install files"


cd
git clone https://github.com/niklaushirt/installcentos.git
cd installcentos
./install-openshift.sh
# ansible-playbook -i inventory.ini openshift-ansible/playbooks/deploy_cluster.yml


echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo " POST INSTALL"
echo ""
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"

echo "Login"
# Your console is https://console.192.168.27.199.nip.io:8443
# Your username is root
# Your password is password
oc login -u root -p password https://console.192.168.27.199.nip.io:8443/

# IMPORTANT !!!!!!
oc edit ds apiserver -n kube-service-catalog
patch https://demo--> IP

# Auto Completion
#https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion

echo 'source <(kubectl completion bash)' >>~/.bashrc

# Create Cluster Role for user
oc adm policy add-cluster-role-to-user cluster-admin root --as=system:admin

oc login -u root -p passw0rd https://console.192.168.27.199.nip.io:8443/


echo "Install Helm"
wget https://get.helm.sh/helm-v2.14.1-linux-amd64.tar.gz
tar -zxvf helm-v2.14.1-linux-amd64.tar.gz
cd linux-amd64
chmod +x helm
mv helm /usr/local/bin/



echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo " UNINSTALL"
echo ""
echo " https://docs.okd.io/latest/install/host_preparation.html"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"

# ansible-playbook -i inventory.ini openshift-ansible/playbooks/adhoc/uninstall.yml




echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo " END"
echo ""
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"


M4g4dinoM4g4dinoM4g4dinoM4g4dino