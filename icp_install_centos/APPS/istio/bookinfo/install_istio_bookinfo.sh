#!/bin/bash
kubectl apply --namespace default -f  ~/INSTALL/APPS/istio/istio/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl apply --namespace default -f ~/INSTALL/APPS/istio/istio/samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl apply --namespace default -f ~/INSTALL/APPS/istio/istio/samples/bookinfo/networking/destination-rule-all.yaml
#kubectl apply --namespace default -f <(istioctl kube-inject -f ~/INSTALL/APPS/istio/bookinfo/bookinfo.yaml)
#kubectl apply --namespace default -f ~/INSTALL/APPS/istio/bookinfo/bookinfo-gateway.yaml
#kubectl apply --namespace default -f ~/INSTALL/APPS/istio/bookinfo/destination-rule-all.yaml

export INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n istio-system -o 'jsonpath={.items[0].status.hostIP}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')

export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage

kubectl get virtualservice
