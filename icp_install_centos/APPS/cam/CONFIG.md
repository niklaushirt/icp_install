

FYRE "veil"

Name          service-deploy-api-key
Description   Api key for service-deploy
Bound To      crn:v1:icp:private:iam-identity:mycluster:n/services::serviceid:ServiceId-d0c4d5ae-736c-41eb-bf56-19b324cbf97b
Created At    2018-10-22T07:37+0000
API Key       T5zRjQF7bvBHLhNtcwwiMDVLJFoBh19VL4T8pOx2Nrz0


helm install --name cam ibm-cam-3.1.0.tgz \
--namespace services \
--set arch=amd64 \
--set global.image.secretName=camsecret \
--set global.iam.deployApiKey=T5zRjQF7bvBHLhNtcwwiMDVLJFoBh19VL4T8pOx2Nrz0 \
--set camBPDResources.requests.cpu=500m \
--set camBPDResources.limits.cpu=600m  \
--tls
