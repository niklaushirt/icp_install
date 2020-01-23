#!/bin/bash


# Install ISTIO
echo "Install ISTIO"


ISTIO_VERSION=1.1.0
OSEXT="linux"

#------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------

cd ~/INSTALL/APPS/istio

echo "Downloading Istio"

export PATH=$PWD/istio/bin:$PATH

echo "Creating chart"
#helm template ~/INSTALL/APPS/istio/istio/install/kubernetes/helm/istio --name istio --namespace istio-system --set grafana.enabled=true --set grafana.service.type=NodePort --set servicegraph.enabled=true --set servicegraph.service.type=NodePort --set kiali.enabled=true --set kiali.service.type=NodePort --set tracing.enabled=true > ~/INSTALL/APPS/istio/istio.yaml
rm ~/INSTALL/APPS/istio/istio.yaml


helm template ~/INSTALL/APPS/istio/istio/install/kubernetes/helm/istio \
--name istio  \
--namespace istio-system  \
--set grafana.enabled=true  \
--set grafana.service.type=NodePort \
--set servicegraph.enabled=true  \
--set servicegraph.service.type=NodePort  \
--set kiali.enabled=true  \
--set kiali.ingress.enabled=true \
--set "kiali.dashboard.jaegerURL=http://jaeger-query:16686" \
--set "kiali.dashboard.grafanaURL=http://grafana:3000" \
--set kiali.createDemoSecret=true \
--set tracing.enabled=true > ~/INSTALL/APPS/istio/istio.yaml



cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: kiali
  namespace: istio-system
  labels:
    app: kiali
type: Opaque
data:
  username: YWRtaW4=
  passphrase: YWRtaW4=
EOF

kubectl apply -f ~/INSTALL/APPS/istio/istio/install/kubernetes/helm/istio-init/files/crd-10.yaml
kubectl apply -f ~/INSTALL/APPS/istio/istio/install/kubernetes/helm/istio-init/files/crd-11.yaml
kubectl apply -f ~/INSTALL/APPS/istio/istio/install/kubernetes/helm/istio-init/files/crd-certmanager-10.yaml
kubectl apply -f ~/INSTALL/APPS/istio/istio/install/kubernetes/helm/istio-init/files/crd-certmanager-11.yaml
#kubectl apply -f ~/INSTALL/APPS/istio/istio/install/kubernetes/helm/istio/templates/crds.yaml
kubectl create namespace istio-system
kubectl apply -f ~/INSTALL/APPS/istio/istio.yaml

kubectl label namespace default istio-injection=enabled
kubectl get ns --show-labels

# Expose KIALI via Node Port
kubectl patch service -n istio-system kiali -p '{"spec": {"ports": [{"nodePort": 31710,"port": 20001,"name": "http-kiali"}],"type": "NodePort"}}'

#Reduce resource reqirements PILOT
kubectl patch deployment -n istio-system istio-pilot -p '{"spec": {"template":{"spec":{"containers": [{"name":"discovery", "resources": {"limits": {"cpu": "100m","memory": "250Mi"},"requests": {"cpu": "70m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n istio-system istio-pilot -p '{"spec": {"template":{"spec":{"containers": [{"name":"istio-proxy", "resources": {"limits": {"cpu": "100m","memory": "250Mi"},"requests": {"cpu": "70m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n istio-system istio-telemetry -p '{"spec": {"template":{"spec":{"containers": [{"name":"mixer", "resources": {"limits": {"cpu": "100m","memory": "250Mi"},"requests": {"cpu": "70m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n istio-system istio-telemetry -p '{"spec": {"template":{"spec":{"containers": [{"name":"istio-proxy", "resources": {"limits": {"cpu": "100m","memory": "250Mi"},"requests": {"cpu": "70m","memory": "100Mi"}}}]}}}}'



kubectl get pods -n istio-system


#cp ~/.bashrc_icp_save ~/.bashrc
#cp ~/.bashrc ~/.bashrc_icp_save
#cat ~/INSTALL/APPS/istio/conf/bashrc_add_istio.sh >> ~/.bashrc
