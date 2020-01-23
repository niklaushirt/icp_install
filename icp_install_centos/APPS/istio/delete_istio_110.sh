#!/bin/bash


kubectl delete --namespace default -f  ~/INSTALL/APPS/istio/istio/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl delete --namespace default -f ~/INSTALL/APPS/istio/istio/samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl delete --namespace default -f ~/INSTALL/APPS/istio/istio/samples/bookinfo/networking/destination-rule-all.yaml

kubectl delete -f ~/INSTALL/APPS/istio/istio/install/kubernetes/helm/istio-init/files/crd-10.yaml
kubectl delete -f ~/INSTALL/APPS/istio/istio/install/kubernetes/helm/istio-init/files/crd-11.yaml
kubectl delete -f ~/INSTALL/APPS/istio/istio/install/kubernetes/helm/istio-init/files/crd-certmanager-10.yaml
kubectl delete -f ~/INSTALL/APPS/istio/istio/install/kubernetes/helm/istio-init/files/crd-certmanager-11.yaml
ystem
kubectl delete -f ~/INSTALL/APPS/istio/istio.yaml

#kubectl delete namespace istio-system
