#!/bin/bash

sudo helm delete --purge --tls openebs



kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: testebs
  namespace: default
spec:
  storageClassName: openebs-standard 
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5G