

oc login -u system:admin
oc project jenkins
oc adm policy add-scc-to-user privileged -z default -n jenkins

oc adm policy add-scc-to-user privileged -z default -n jenkins



kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts:jenkins

oc new-app -e OPENSHIFT_ENABLE_OAUTH=false -e VOLUME_CAPACITY=10Gi openshift/jenkins-2-centos7:v3.11





jenkins-2-centos7:v3.11








PATCH='{"metadata":{"labels":{"app":"jenkins-2-centos7"}}}'

oc -n jenkins patch sa jenkins -p $PATCH











export YOUR_NAMESPACE=jenkins

kubectl apply -f jenkins-prep.yaml

oc login -u system:admin

oc project ${YOUR_NAMESPACE}
oc adm policy add-scc-to-user privileged -z default -n ${YOUR_NAMESPACE}
oc adm policy add-scc-to-user anyuid -z privileged -n ${YOUR_NAMESPACE}



helm upgrade --install jenkins stable/jenkins --namespace jenkins


helm upgrade --install jenkins -f values.yaml stable/jenkins --namespace jenkins


printf $(kubectl get secret --namespace jenkins jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo



helm delete jenkins --purge