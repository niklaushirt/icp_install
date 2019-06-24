#!/bin/bash
ISTIO_VERSION=1.0.2
OSEXT="linux"
NAME="istio-$ISTIO_VERSION"

kubectl delete --namespace default -f  ~/INSTALL/APPS/istio/istio/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl delete --namespace default -f ~/INSTALL/APPS/istio/istio/samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl delete --namespace default -f ~/INSTALL/APPS/istio/istio/samples/bookinfo/networking/destination-rule-all.yaml
