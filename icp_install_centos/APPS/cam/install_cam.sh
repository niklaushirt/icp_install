#!/bin/bash

# Create some Stuff
echo "Prepare some Stuff"
source ~/INSTALL/0_variables.sh

cd ~/INSTALL/

helm repo add ibm-stable https://raw.githubusercontent.com/IBM/charts/master/repo/stable/
helm repo update
helm fetch ibm-stable/ibm-cam --version 3.1.3

kubectl create secret docker-registry camsecret --docker-username=${DOCKER_HUB_LOGIN} --docker-password=${DOCKER_HUB_PWD} --docker-email=${DOCKER_HUB_MAIL} -n services


export serviceIDName='service-deploy'
export serviceApiKeyName='service-deploy-api-key'
cloudctl login -a https://mycluster.icp:8443 --skip-ssl-validation -u admin -p admin -n services  -c id-mycluster-account
cloudctl iam service-id-create ${serviceIDName} -d 'Service ID for service-deploy'
cloudctl iam service-policy-create ${serviceIDName} -r Administrator,ClusterAdministrator --service-name 'idmgmt'
cloudctl iam service-policy-create ${serviceIDName} -r Administrator,ClusterAdministrator --service-name 'identity'
cloudctl iam service-api-key-create ${serviceApiKeyName} ${serviceIDName} -d 'Api key for service-deploy'

export serviceIDName='service-deploy'
export serviceApiKeyName='service-deploy-api-key'
cloudctl login -a https://mycluster.icp:8443 --skip-ssl-validation -u <icp_admin_id> -p <icp_admin_password> -n services
cloudctl iam service-id-create ${serviceIDName} -d 'Service ID for service-deploy'
cloudctl iam service-policy-create ${serviceIDName} -r Administrator,ClusterAdministrator --service-name 'idmgmt'
cloudctl iam service-policy-create ${serviceIDName} -r Administrator,ClusterAdministrator --service-name 'identity'
cloudctl iam service-api-key-create ${serviceApiKeyName} ${serviceIDName} -d 'Api key for service-deploy'




echo "Copy and input deploy key"
read camApiKey
echo "Install Chart"
helm install --name cam ibm-cam-3.1.3.tgz \
--namespace services \
--set arch=amd64 \
--set global.image.secretName=camsecret \
--set global.iam.deployApiKey=$camApiKey \
--set camBPDResources.requests.cpu=300m \
--set camBPDResources.limits.cpu=300m  \
--set camBPDResources.requests.memory=100m  \
--tls






helm install --name cam ibm-cam-3.1.3.tgz \
--namespace services \
--set arch=amd64 \
--set global.image.secretName=camsecret \
--set global.iam.deployApiKey=wY57vxZUJ7DHrZUuiMeyDqGBsfibx8GUEreqa7jOAeM \
--set camBPDResources.requests.cpu=300m \
--set camBPDResources.limits.cpu=300m  \
--set camBPDResources.requests.memory=100m  \
--tls





helm template --name cam ibm-cam-3.1.0.tgz \
--namespace services \
--set arch=amd64 \
--set global.image.secretName=camsecret \
--set global.iam.deployApiKey=GaT_S4mD_fNAPtPKIcxSWK692m5oQ8ekMfm5HjoR2p3F \
--set auditService.limits.memory=128Mi  \
--set auditService.limits.cpu=200m  \
--set auditService.requests.memory=128Mi  \
--set auditService.requests.cpu=200m  \
--set resources.requests.memory=128Mi  \
--set resources.requests.cpu=200m  \
--set resources.limits.memory=128Mi  \
--set resources.limits.cpu=200m  \
--set camMongoPV.persistence.existingClaimName=cam-mongo-pv \
--set camLogsPV.persistence.existingClaimName=cam-logs-pv \
--set camTerraformPV.persistence.existingClaimName=cam-terraform-pv \
--set camBPDAppDataPV.persistence.existingClaimName=cam-bpd-appdata-pv \
--set camBPDUI.bundled="false" \
--tls
