
# MCM ApplicationService

## STATUS

kubectl get clusters --all-namespaces
kubectl get application --all-namespaces
kubectl get pp --all-namespaces
kubectl get work --all-namespaces

kubectl get helmrepo --all-namespaces

## EDIT PLACEMENT
KUBE_EDITOR="nano" kubectl edit pp --namespace default

## DELETE
kubectl delete --namespace default deployables demo-openliberty
kubectl delete --namespace mcm-namespace work demo-openliberty-fyre
kubectl delete --namespace default pp demo-openliberty
kubectl delete --namespace default pp demo-openliberty



# MCM COMPLIANCES
kubectl get compliances --all-namespaces
kubectl get policies --all-namespaces

kubectl get policies -n mcm-namespace policy-operator -o yaml

kubectl delete compliances -n default compliance-simple1

kubectl get role --all-namespaces --show-labels
kubectl label role operator hippa=true -n mcm-namespace
kubectl delete role dev -n mcm-namespace
kubectl delete role operator -n mcm-namespace







KUBE_EDITOR="nano" kubectl edit pp --namespace default
mcmctl get clusters --all-namespaces
mcmctl get helmrepos  --all-namespaces

mcmctl get deployables --all-namespaces
mcmctl get work --all-namespaces

mcmctl delete deployables --namespace default demo-app
mcmctl delete work --namespace mcm-namespace demo-app
kubectl delete clusters icp-local2 --namespace mcm-ns


kubectl get compliances --all-namespaces -o yaml

kubectl apply --namespace mcm-namespace -f ~/INSTALL/APPS/mcm/demo/demos/compliance/compliances/compliance-v0.2.yaml
kubectl delete compliance --namespace mcm-namespace compliance1

kubectl create -f INSTALL/APPS/mcm/demo/demos/compliance/compliances/compliance-v0.2.yaml -n mcm-namespace


# Install and Configure MCM for demos

## Installation instructions
- Full instuctions here: https://github.ibm.com/IBMPrivateCloud/roadmap/issues/14125
- And here: https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/ibm-multi-cloud/install.html

### On the Hub (min version 3.1)
- Upload PPA package
- Note cluster URL from kubeconfig
- Note token from kubeconfig
- Create secret using helm certificates:  
```
kubectl create secret tls klusterlet-tiller-secret --cert ~/.helm/cert.pem --key ~/.helm/key.pem -n kube-system
```
- Create Persistent Volumes for ETCD and Prometheus
- Deploy the mcm-controller (**no klusterlet**). Make sure that:
  - MCM is deployed to `kube-system` namespace
  - A new namespace for MCM is created prior to deployment
- Deploy the mcm-klusterlet chart using the parameters above.
  - Give the cluster a unique name
  - Give the namespace a unique name
- After deployment, patch the catalog UI:  
```
$ kubectl patch daemonset catalog-ui --patch '{"spec": {"template":{"spec":{"containers":[{"name":"catalog-ui","env":[{"name":"hcmCapabilityEnabled","value":"true"},{"name":"hcmRedirectUrl","value":"https://'${CLUSTER_IP}':8443/hcmconsole/remoteinstall"}]}]}}}}' -n kube-system
```

### On the slave - Same network
- Upload PPA package
- Note hub's cluster URL (see above)
- Note hub's token (see above)
- Create secret using helm certificates:  
```
kubectl create secret tls klusterlet-tiller-secret --cert ~/.helm/cert.pem --key ~/.helm/key.pem -n kube-system
```
- Deploy the mcm-klusterlet chart using the parameters above.
  - Give the cluster a unique name
  - Give the namespace a unique name

### On the slave - Different network
- Do a client authentication using `kubectl` against the **hub**, then copy the `~/.kube/config` file into the `config/hub` directory
- Do a client authentication using `kubectl` against the **slave**, then copy the `~/.kube/config` file into the `config/slave` directory
- Do a client authentication using `cloudctl` or `bx pr` against the **slave**, then copy the `~/.helm/cert.pem` and `~/.helm/key.pem` files into the `config/slave` directory
- Copy the `MCM` directory to the **hub**'s master node
- Log into the bluemix docker registry:  
```
$ docker login -u token -p <Artifactory API Key> registry.ng.bluemix.net/icp-integration/
```
- Define CLUSTER_NAME in the `remote_cluster.sh` script
- Run the `remote_cluster.sh` script

## Demos
### Demo trader
- Go into `demos/trader/helm` and deploy the google repo:
```
mcmctl create -f helmrepo.yaml
```
- Go into `demos/trader` and deploy the traderapp yaml files:
```
mcmctl create -Rf traderapp/
```

### Demo guestbook
**Note: in ICP 3.1 the clusterimagepolicy needs to edited to allow the guestbook images to be used**
- Edit the gbapp helm chart in `demos/guestbook/gbapp`
- Package the helm chart:
```
helm package demos/guestbook/gbapp
```
- Upload the chart to the repository
```
$ cloudctl catalog load-chart --archive <helm_chart_archive>
```
- Deploy the helm chart from the UI or via CLI:
```
$ helm upgrade --install ${HELM_RELEASE_NAME} gbapp --namespace ${CLUSTER_NAMESPACE} --tls
```
- Retrieve policy policy:
```
kubectl get pp --all-namespaces
```
- Edit number of replicas in the policy:
```
$ kubectl edit pp <placement_policy_name>
```
- Look at the app being deployed across clusterSelector

### Demo compliance
- Show compliance policies in `demos/compliance/compliances/compliance-v0.2.yaml`
- Make sure one policy is on `inform` and the other on `enforce`
- Deploy compliance policy:
```
kubectl apply -f demos/compliance/compliances/compliance-v0.2.yaml
```
- Show the results in the GUI: enforce rules are applied, inform are only signalled
- To delete the new roles `dev` and `operator`, type:
```
$ kubectl delete role <role_name> -n default
```




KUBE_EDITOR="nano" kubectl edit pp hellonode















apiVersion: mcm.ibm.com/v1alpha1
kind: Application
metadata:
  name: guestbook-gbapp
  labels:
    name: guestbook-gbapp
    app: gbapp
    chart: gbapp-0.1.0
    heritage: Tiller
    release: guestbook
  namespace: default
spec:
  componentKinds:
    - group: core
      kind: Pods
  descriptor: {}
  selector:
    matchExpressions:
      - key: app
        operator: In
        values:
          - gbapp
          - gbf
          - gbrm
          - gbrs
---
apiVersion: mcm.ibm.com/v1alpha1
kind: Deployable
metadata:
  name: guestbook-gbapp
  labels:
    name: guestbook-gbapp
    app: gbapp
    chart: gbapp-0.1.0
    heritage: Tiller
    release: guestbook
    servicekind: ApplicationService
  namespace: default
spec:
  deployer:
    helm:
      chartURL: >-
        https://raw.githubusercontent.com/abdasgupta/helm-repo/master/3.1-mcm-guestbook/gbf-0.1.0.tgz
      namespace: default
    kind: helm
---
apiVersion: mcm.ibm.com/v1alpha1
kind: Deployable
metadata:
  name: guestbook-gbapp-redismaster
  labels:
    name: guestbook-gbapp-redismaster
    app: gbapp
    chart: gbapp-0.1.0
    heritage: Tiller
    release: guestbook
    servicekind: CacheService
  namespace: default
spec:
  deployer:
    helm:
      chartURL: >-
        https://raw.githubusercontent.com/abdasgupta/helm-repo/master/3.1-mcm-guestbook/gbrm-0.1.0.tgz
      namespace: default
    kind: helm
---
apiVersion: mcm.ibm.com/v1alpha1
kind: Deployable
metadata:
  name: guestbook-gbapp-redisslave
  labels:
    name: guestbook-gbapp-redisslave
    app: gbapp
    chart: gbapp-0.1.0
    heritage: Tiller
    release: guestbook
    servicekind: CacheService
  namespace: default
spec:
  deployer:
    helm:
      chartURL: >-
        https://raw.githubusercontent.com/abdasgupta/helm-repo/master/3.1-mcm-guestbook/gbrs-0.1.0.tgz
      namespace: default
    kind: helm
---
apiVersion: mcm.ibm.com/v1alpha1
kind: PlacementPolicy
metadata:
  name: guestbook-gbapp
  labels:
    name: guestbook-gbapp
    app: gbapp
    chart: gbapp-0.1.0
    heritage: Tiller
    release: guestbook
    servicekind: CacheService
  namespace: default
spec:
  clusterSelector:
    matchLabels:
      cloud: IBM
      environment: Prod
  replicas: 1
  resourceSelector: {}
