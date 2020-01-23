zTgTXDWaX-l6-KZ6XdVONeokbI4xtxaTcl-BBfFRXU-F



helm install --name cam ibm-cam-3.1.1.tgz \
--namespace services \
--set arch=amd64 \
--set global.image.secretName=camsecret \
--set global.iam.deployApiKey=zTgTXDWaX-l6-KZ6XdVONeokbI4xtxaTcl-BBfFRXU-F \
--set camBPDResources.requests.cpu=300m \
--set camBPDResources.limits.cpu=300m  \
--tls
