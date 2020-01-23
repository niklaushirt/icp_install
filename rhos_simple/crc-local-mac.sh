
scp IBM/3_RHOCP/crc-linux-amd64.tar.xz root@192.168.27.180:/home/demo

scp IBM/3_RHOCP/pull-secret root@192.168.27.180:/home/demo


tar xf crc-linux-amd64.tar.xz

sudo mv crc-linux-1.2.0-amd64/crc /usr/local/bin


crc config view

crc config set pull-secret-file /root/pull-secret
crc config set memory 16800
crc config set cpus 4

crc config view

crc setup

crc start






crc config view

crc config set pull-secret-file /Users/nhirt/VMWARE/pull-secret
crc config set memory 6800
crc config set cpus 4

crc config view

crc setup

crc start
