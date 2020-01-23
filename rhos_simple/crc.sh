wget https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/crc-macos-amd64.tar.xz?extIdCarryOver=true&sc_cid=701f2000000RlyIAAS
wget https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz


tar xf crc-linux-amd64.tar.xz

mv crc /usr/local/bin

sudo chmod 0666 /etc/hosts 
sudo chmod 0666 /etc/resolv.conf 

crc setup

crc start --cpus 6 --memory 16384

start --cpus=4 --memory=13000 -p=./pull-secret --nameserver=8.8.8.8


{"auths":{"cloud.openshift.com":{"auth":"b3BlbnNoaWZ0LXJlbGVhc2UtZGV2K25pa2xhdXNoaXJ0MW5vb3puenR5c3J4YTl2eXRjNDFsd3Z1bXQyOlI2RFpFTURMREM5RkM3T0tON0tBNVNIUlhRWDQyODBJUkpRNUc0NlpVSUwwS0lOTzFJNVM2T0hBSDQ5SUZKN0k=","email":"niklaushirt@gmail.com"},"quay.io":{"auth":"b3BlbnNoaWZ0LXJlbGVhc2UtZGV2K25pa2xhdXNoaXJ0MW5vb3puenR5c3J4YTl2eXRjNDFsd3Z1bXQyOlI2RFpFTURMREM5RkM3T0tON0tBNVNIUlhRWDQyODBJUkpRNUc0NlpVSUwwS0lOTzFJNVM2T0hBSDQ5SUZKN0k=","email":"niklaushirt@gmail.com"},"registry.connect.redhat.com":{"auth":"NzE3NTE2OHx1aGMtMU5vT3pOWnRZU1JYYTl2eXRDNDFsd1Z1TXQyOmV5SmhiR2NpT2lKU1V6VXhNaUo5LmV5SnpkV0lpT2lKbE56VTRNREU0TldVek5USTBNV1JtT1RFeU56TmxOR0UzTWpObVlqVTVNU0o5LnY5Vk1RbVoybVVmN3JtMHV0WTlUN2tydGlWY1Q4NDFoYUMtRXRaSnpSOHpwQ3Z2ekVlaVJPSUhKNFFmRkZjcjZTMXVTcEFJdkVsRENiTjBJTjJzeU1SY1JiWDBKZ1RCdUFvckdGZHZfdkUtWDN3NUpzSV9rRXIyX0hQQm9neDBzNWJ1eGN6Uk9VeDdKYkJkdk1aMm5LRVhpbjJZdHkzenROaGtIR1ZtdUYtS2NGZXV0dkxhZmZSck4zV3hmN1Awem9WbnVqN2Z4ZEpYanZBdjNrd2pxS1kwOTdNcUI2dnN4ZWN4Xy1acndCcldocG11LW9PbXdsWU00RkFLYUN5QTJJanpNckdCdXE3RG03a2h6SDZDejlTb3RVLWtvRFQ0ZlV1YVdfWkQ1UkhsSmJmVVBfQ1VtcVJpOXJ1UUF4TWpPUVJvQkFEWFcySDU4OVVIV3FLeXRNUXFPQTJndjJjbkRTQ3I2bWU4Z0ZZS3QwWnBPcmJWWGJxQ2xmYkJDaDNXQW1ETGdqZzBKWDR6UWs4OXNEV2NLWU81ckFnMlZuMWg2TzdHb2Zsc1FINV9jRzhiQkxuZVZmb0FUWlVBcXBFa3QxU3JTS1MwQlNCTUx3MExwbUdFVm5BRUhxQVB6OXVvVzctZm1RVHBvYUNVYmd5b2xNbzgwdTdmeEh6aXZoZHpPZ0F1UldOcTh1MmlzbzNhQmdsOGFSaFh1aDBrbzNWM0xoYUwzSnNXUGxIcFdqRERCNVZfd0N5dE1mcVhiS2wzQWV6OG5UX0NfS2c3N0dCOHBzRWF0SGEzdzhTeVlnMGk2bnNURk4xT29NRnBWUUUtd2RsdEdUbk1QTVZVb2QtajFTTTdYclFLRndIaFh6Q3ZpdTg1OVNfVFdKa0FlMVFJY0xNaWhKNG5EOXln","email":"niklaushirt@gmail.com"},"registry.redhat.io":{"auth":"NzE3NTE2OHx1aGMtMU5vT3pOWnRZU1JYYTl2eXRDNDFsd1Z1TXQyOmV5SmhiR2NpT2lKU1V6VXhNaUo5LmV5SnpkV0lpT2lKbE56VTRNREU0TldVek5USTBNV1JtT1RFeU56TmxOR0UzTWpObVlqVTVNU0o5LnY5Vk1RbVoybVVmN3JtMHV0WTlUN2tydGlWY1Q4NDFoYUMtRXRaSnpSOHpwQ3Z2ekVlaVJPSUhKNFFmRkZjcjZTMXVTcEFJdkVsRENiTjBJTjJzeU1SY1JiWDBKZ1RCdUFvckdGZHZfdkUtWDN3NUpzSV9rRXIyX0hQQm9neDBzNWJ1eGN6Uk9VeDdKYkJkdk1aMm5LRVhpbjJZdHkzenROaGtIR1ZtdUYtS2NGZXV0dkxhZmZSck4zV3hmN1Awem9WbnVqN2Z4ZEpYanZBdjNrd2pxS1kwOTdNcUI2dnN4ZWN4Xy1acndCcldocG11LW9PbXdsWU00RkFLYUN5QTJJanpNckdCdXE3RG03a2h6SDZDejlTb3RVLWtvRFQ0ZlV1YVdfWkQ1UkhsSmJmVVBfQ1VtcVJpOXJ1UUF4TWpPUVJvQkFEWFcySDU4OVVIV3FLeXRNUXFPQTJndjJjbkRTQ3I2bWU4Z0ZZS3QwWnBPcmJWWGJxQ2xmYkJDaDNXQW1ETGdqZzBKWDR6UWs4OXNEV2NLWU81ckFnMlZuMWg2TzdHb2Zsc1FINV9jRzhiQkxuZVZmb0FUWlVBcXBFa3QxU3JTS1MwQlNCTUx3MExwbUdFVm5BRUhxQVB6OXVvVzctZm1RVHBvYUNVYmd5b2xNbzgwdTdmeEh6aXZoZHpPZ0F1UldOcTh1MmlzbzNhQmdsOGFSaFh1aDBrbzNWM0xoYUwzSnNXUGxIcFdqRERCNVZfd0N5dE1mcVhiS2wzQWV6OG5UX0NfS2c3N0dCOHBzRWF0SGEzdzhTeVlnMGk2bnNURk4xT29NRnBWUUUtd2RsdEdUbk1QTVZVb2QtajFTTTdYclFLRndIaFh6Q3ZpdTg1OVNfVFdKa0FlMVFJY0xNaWhKNG5EOXln","email":"niklaushirt@gmail.com"}}}



crc console


oc scale --replicas=1 statefulset --all -n openshift-monitoring; oc scale --replicas=1 deployment --all -n openshift-monitoring



oc login -u admin -p F44En-Xau6V-jQuyb-yuMXB https://api.crc.testing:6443



oc scale --replicas=1 statefulset --all -n openshift-monitoring; oc scale --replicas=1 deployment --all -n openshift-monitoring
oc get nodes
crc oc-env
./crc oc-env
export PATH="/Users/nhirt/.crc/bin:$PATH"
eval $(crc oc-env)
eval $(./crc oc-env)
oc get nodes

eval $(crc oc-env)
oc get nodes
ll
eval $(crc oc-env)
oc login -u developer -p developer https://api.crc.testing:6443
oc get nodes
oc scale --replicas=1 statefulset --all -n openshift-monitoring; oc scale --replicas=1 deployment --all -n openshift-monitoring
oc login -u admin -p F44En-Xau6V-jQuyb-yuMXB  https://api.crc.testing:6443
F44En-Xau6V-jQuyb-yuMXB
oc login --token=fCRpJh_qhY8mzoxfY6Ll2fNMXpoNjnjETmAjOpNsHaQ --server=https://api.crc.testing:6443
oc scale --replicas=1 statefulset --all -n openshift-monitoring; oc scale --replicas=1 deployment --all -n openshift-monitoring
crc start --help


crc delete 