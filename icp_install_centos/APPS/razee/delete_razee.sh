#!/bin/bash

source ~/INSTALL/0_variables.sh


kubectl delete -f https://github.com/razee-io/Kapitan-delta/releases/latest/download/resource.yaml

kubectl delete -f https://github.com/razee-io/Razee/releases/latest/download/resource.yaml

kubectl delete configmap razeedash-config -n razee 