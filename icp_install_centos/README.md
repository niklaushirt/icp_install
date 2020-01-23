
# FIRST Install

```
git clone https://github.com/niklaushirt/icp_ubuntu_install.git INSTALL
cd INSTALL
```


# Useful commands

until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
until kubectl get customresourcedefinitions; do date; sleep 1; echo ""; done


kubectl create rolebinding -n default ibm-privileged-clusterrole --clusterrole=ibm-privileged-clusterrole --group=system:serviceaccounts:default


kubectl api-resources -o wide
kubectl get events --all-namespaces --field-selector type=Warning

kubectl get events --all-namespaces --field-selector type!=Normal
kubectl get events --all-namespaces --field-selector involvedObject.kind!=Pod

kubectl get deployments -v=7

kubectl top pods --all-namespaces



# Edit Resoure with NANO
KUBE_EDITOR="nano" kubectl edit clusterrolebinding ibm-privileged-psp-users
