kubectl create namespace ta

kubectl create serviceaccount -n ta ta-sa

kubectl -n ta create -f- <<EOF
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: ta-psp
spec:
  allowPrivilegeEscalation: true
  readOnlyRootFilesystem: false
  allowedCapabilities:
  - CHOWN
  - DAC_OVERRIDE
  - FOWNER
  - FSETID
  - KILL
  - SETGID
  - SETUID
  - SETPCAP
  - NET_BIND_SERVICE
  - NET_RAW
  - SYS_CHROOT
  - AUDIT_WRITE
  - SETFCAP
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: RunAsAny
  runAsUser:
    rule: RunAsAny
  fsGroup:
    rule: RunAsAny
  volumes:
  - '*'
EOF

kubectl -n ta create role psp:unprivileged \
    --verb=use \
    --resource=podsecuritypolicy \
    --resource-name=ta-psp

kubectl -n ta create rolebinding ta-sa:psp:unprivileged \
    --role=psp:unprivileged \
    --serviceaccount=ta:ta-sa


kubectl -n services create secret generic transformation-advisor-secret --from-literal=db_username='admin' --from-literal=secret='admin'

helm repo update
helm fetch ibm-stable/ibm-transadv-dev

helm install --name ta --set authentication.icp.edgeIp=9.30.147.120 --set authentication.icp.secretName=transformation-advisor-secret ibm-stable/ibm-transadv-dev --tls
