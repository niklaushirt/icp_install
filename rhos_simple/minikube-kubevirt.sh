https://kubevirt.io/quickstart_minikube/
https://kubernetes.io/docs/tasks/tools/install-minikube/
https://minikube.sigs.k8s.io/docs/reference/drivers/kvm2/
https://help.ubuntu.com/community/KVM/Installation
https://github.com/kubevirt/kubevirt/releases
https://kubevirt.io/labs/kubernetes/lab1

sudo apt-get install qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils
sudo apt-get install virt-manager


sudo adduser demo libvirtd

sudo virsh list --all

sudo chown -R demo:libvirtd /var/run/libvirt

sudo apt install curl
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64   && chmod +x minikube
mv minikube /usr/local/bin/
sudo mv minikube /usr/local/bin/
minikube config -p kubevirt set memory 12000
minikube config -p kubevirt set vm-driver kvm2
minikube start -p kubevirt
sudo minikube start -p kubevirt


sudo chown -R demo:kvm /dev/kvm
sudo chown -R demo:libvirtd /var/run/libvirt

minikube -p kubevirt dashboard


wget https://github.com/derailed/k9s/releases/download/0.8.4/k9s_0.8.4_Linux_x86_64.tar.gz
tar -zxvf k9s_0.8.4_Linux_x86_64.tar.gz
chmod +x k9s
sudo mv k9s /usr/local/bin/
sudo rm k9s_0.8.4_Linux_x86_64.tar.gz
