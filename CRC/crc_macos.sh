
scp IBM/3_RHOCP/crc-linux-amd64.tar.xz root@192.168.27.180:/home/demo

scp IBM/3_RHOCP/pull-secret root@192.168.27.180:/home/demo


tar xf crc-macos-amd64.tar.xz

sudo mv crc-macos-1.4.0-amd64/crc /usr/local/bin


crc config view

crc config set pull-secret-file /Users/nhirt/Documents/pull-secret
crc config set memory 16800
crc config set cpus 12

crc config view

crc setup
chmod 0600 /etc/hosts
crc start

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
