#!/bin/bash

source ~/INSTALL/0_variables.sh

helm repo add demo https://raw.githubusercontent.com/niklaushirt/charts/master/helm/charts/repo/stable

helm install demo/kubernetes-dashboard --name kubernetes-dashboard --namespace default --tls
