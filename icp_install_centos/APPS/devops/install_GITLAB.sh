wget https://get.helm.sh/helm-v2.16.1-linux-amd64.tar.gz
tar -zxvf  helm-v2.16.1-linux-amd64.tar.gz
cd linux-amd64
chmod 700 helm
mv helm /usr/local/bin


klogin

export YOUR_NAMESPACE=gitlab


oc login -u system:admin


oc project ${YOUR_NAMESPACE}
oc adm policy add-scc-to-user anyuid -z default -n ${YOUR_NAMESPACE}
oc adm policy add-scc-to-user anyuid -z gitlab-runner -n ${YOUR_NAMESPACE}


kubectl create -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/doc/installation/examples/rbac-config.yaml
helm init --service-account tiller


helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600 \
  --values gitlab-minimal.yaml \
  --set nginx-ingress.enabled=false \
  --set global.hosts.domain=192.168.27.199.nip.io  \
  --set global.hosts.externalIP=192.168.27.199 \
  --set global.edition=ce \
  --set certmanager-issuer.email=nikh@ch.ibm.com






kubectl get secret <name>-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo







helm template gitlab/gitlab --name gitlab
  --values gitlab-minimal.yaml \
  --set nginx-ingress.enabled=false \
  --set global.hosts.domain=192.168.27.199.nip.io  \
  --set global.hosts.externalIP=192.168.27.199 \
  --set global.edition=ce \
  --set certmanager-issuer.email=nikh@ch.ibm.com

