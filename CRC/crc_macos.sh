
scp IBM/3_RHOCP/crc-linux-amd64.tar.xz root@192.168.27.180:/home/demo

scp IBM/3_RHOCP/pull-secret root@192.168.27.180:/home/demo



scp ./IBM/3_RHOCP/crc-linux-amd64.tar.xz root@192.168.27.111:/root

scp ./Documents/pull-secret root@192.168.27.111:/root

tar xf crc-linux-amd64.tar.xz
chmod +x crc-linux-1.5.0-amd64/crc
mv crc-linux-1.5.0-amd64/crc /usr/local/bin/

crc config set pull-secret-file ./pull-secret
crc config set memory 22800
crc config set cpus 7
crc config view

crc setup
crc start --log-level debug


tar xf crc-macos-amd64.tar.xz

sudo mv crc-macos-1.4.0-amd64/crc /usr/local/bin


crc config view

crc config set pull-secret-file /Users/nhirt/Documents/pull-secret
crc config set memory 32800
crc config set cpus 12

crc config view

crc setup
chmod 0600 /etc/hosts
crc start --log-level debug

crc stop


crc oc-env
crc console


oc scale --replicas=1 statefulset --all -n openshift-monitoring; oc scale --replicas=1 deployment --all -n openshift-monitoring

oc get packagemanifests -n marketplace



oc get nodeslock
oc debug nodes/crc-shdl4-master-0


sudo touch ../resolver
scutil --dns
dig google.com
dns-sd -G v4 images.apple.com
nslookup testing



ssh -i ~/.crc/cache/crc_libvirt_4.1.11/id_rsa_crc core@192.168.130.11
sudo -i




crc delete
cd ~/.crc/bin
rm hyperkit
curl -L -O https://686-55985023-gh.circle-artifacts.com/0/hyperkit
chmod +x hyperkit
sudo chown root:wheel hyperkit 
sudo chmod u+s hyperkit
./hyperkit -version

crc start --log-level debug

ps -Af | grep hyperkit
sudo vmnet



