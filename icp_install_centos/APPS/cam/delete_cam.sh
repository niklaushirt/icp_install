#!/bin/bash

helm delete --tls --purge cam

kubectl delete pvc cam-bpd-appdata-pv --namespace services --force --grace-period 0
kubectl delete pvc cam-logs-pv --namespace services --force --grace-period 0
kubectl delete pvc cam-mongo-pv --namespace services --force --grace-period 0
kubectl delete pvc cam-terraform-pv --namespace services --force --grace-period 0

cloudctl iam service-id-delete service-deploy -f
cloudctl iam service-id-delete service-cloud-automation-manager -f

kubectl delete secret camsecret -n services




kubectl delete pv cam-bpd-appdata-pv --namespace services --force --grace-period 0
kubectl delete pv cam-logs-pv --namespace services --force --grace-period 0
kubectl delete pv cam-mongo-pv --namespace services --force --grace-period 0
kubectl delete pv cam-terraform-pv --namespace services --force --grace-period 0
