kubectl patch deployment -n kube-system calico-kube-controllers -p '{"spec": {"template":{"spec":{"containers": [{"name":"calico-kube-controllers", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi""cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system custom-metrics-adapter -p '{"spec": {"template":{"spec":{"containers": [{"name":"custom-metrics-adapter", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system default-backend -p '{"spec": {"template":{"spec":{"containers": [{"name":"default-http-backend", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system heapster -p '{"spec": {"template":{"spec":{"containers": [{"name":"heapster", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system helm-api -p '{"spec": {"template":{"spec":{"containers": [{"name":"helmapi", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system helm-repo -p '{"spec": {"template":{"spec":{"containers": [{"name":"helm-repo", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system ibmcloud-image-enforcement -p '{"spec": {"template":{"spec":{"containers": [{"name":"ibmcloud-image-enforcement", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system key-management-api -p '{"spec": {"template":{"spec":{"containers": [{"name":"key-management-api", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system key-management-crypto -p '{"spec": {"template":{"spec":{"containers": [{"name":"key-management-crypto", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system key-management-lifecycle -p '{"spec": {"template":{"spec":{"containers": [{"name":"key-management-lifecycle", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system key-management-pep -p '{"spec": {"template":{"spec":{"containers": [{"name":"key-management-pep", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system key-management-persistence -p '{"spec": {"template":{"spec":{"containers": [{"name":"key-management-persistence", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system logging-elk-client -p '{"spec": {"template":{"spec":{"containers": [{"name":"es-client", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system logging-elk-kibana -p '{"spec": {"template":{"spec":{"containers": [{"name":"kibana", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system logging-elk-logstash -p '{"spec": {"template":{"spec":{"containers": [{"name":"logstash", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system logging-elk-master -p '{"spec": {"template":{"spec":{"containers": [{"name":"es-master", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system mcmk-ibm-mcmk-prod-klusterlet -p '{"spec": {"template":{"spec":{"containers": [{"name":"mcmk-ibm-mcmk-prod-klusterlet", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system mcmk-ibm-mcmk-prod-weave-scope-app -p '{"spec": {"template":{"spec":{"containers": [{"name":"mcmk-ibm-mcmk-prod-weave-scope-app", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system metering-dm -p '{"spec": {"template":{"spec":{"containers": [{"name":"metering-dm", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system metering-ui -p '{"spec": {"template":{"spec":{"containers": [{"name":"metering-ui", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system metrics-server -p '{"spec": {"template":{"spec":{"containers": [{"name":"metrics-server", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system mgmt-repo -p '{"spec": {"template":{"spec":{"containers": [{"name":"mgmt-repo", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system monitoring-grafana -p '{"spec": {"template":{"spec":{"containers": [{"name":"grafana", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system monitoring-prometheus -p '{"spec": {"template":{"spec":{"containers": [{"name":"prometheus", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system monitoring-prometheus-alertmanager -p '{"spec": {"template":{"spec":{"containers": [{"name":"alertmanager", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system monitoring-prometheus-collectdexporter -p '{"spec": {"template":{"spec":{"containers": [{"name":"collectd-exporter", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system monitoring-prometheus-elasticsearchexporter -p '{"spec": {"template":{"spec":{"containers": [{"name":"elasticsearchexporter", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system monitoring-prometheus-kubestatemetrics -p '{"spec": {"template":{"spec":{"containers": [{"name":"kubestatemetrics", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system nfs-dynamic-nfs-client-provisioner -p '{"spec": {"template":{"spec":{"containers": [{"name":"nfs-dynamic-nfs-client-provisioner", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system platform-api -p '{"spec": {"template":{"spec":{"containers": [{"name":"platform-api", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system platform-deploy -p '{"spec": {"template":{"spec":{"containers": [{"name":"platform-deploy", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system secret-watcher -p '{"spec": {"template":{"spec":{"containers": [{"name":"secret-watcher", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system service-catalog-controller-manager -p '{"spec": {"template":{"spec":{"containers": [{"name":"controller-manager", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system tiller-deploy -p '{"spec": {"template":{"spec":{"containers": [{"name":"tiller", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'
kubectl patch deployment -n kube-system web-terminal -p '{"spec": {"template":{"spec":{"containers": [{"name":"web-terminal", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {"cpu": "100m","memory": "100Mi"}}}]}}}}'





kubectl patch deployment drupal-drupal --type=json -p='[{"op": "remove", "path": "/spec/selector/matchLabels/chart"}]'


kubectl patch daemonset catalog-ui --patch '{"spec": {"template":{"spec":{"containers":[{"name":"catalog-ui","env":[{"name":"hcmCapabilityEnabled","value":"true"},{"name":"hcmRedirectUrl","value":"https://'${CLUSTER_IP}':8443/hcmconsole/remoteinstall"}]}]}}}}' -n kube-system



kubectl patch deployment -n kube-system xxxxxx -p '{"spec": {"template":{"spec":{"containers": [{"resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'




kubectl patch deployment -n kube-system web-terminal -p '{"spec": {"template":{"spec":{"containers": [{"name":"web-terminal", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'

kubectl patch deployment -n kube-system monitoring-prometheus -p '{"spec": {"template":{"spec":{"containers": [{"name":"prometheus", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {}}}]}}}}'

kubectl patch deployment -n kube-system auth-apikeys -p '{"spec": {"template":{"spec":{"containers": [{"name":"auth-apikeys", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {}}}]}}}}'
kubectl patch deployment -n kube-system xxxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxx", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {}}}]}}}}'
kubectl patch deployment -n kube-system xxxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxx", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {}}}]}}}}'
kubectl patch deployment -n kube-system xxxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxx", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {}}}]}}}}'
kubectl patch deployment -n kube-system xxxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxx", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {}}}]}}}}'
kubectl patch deployment -n kube-system xxxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxx", "resources": {"limits": {"cpu": "200m","memory": "250Mi"},"requests": {}}}]}}}}'






kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'
kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'
kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'
kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'
kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'
kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'
kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'
kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'
kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'
kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'
kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'
kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'
kubectl patch deployment -n kube-system xxx -p '{"spec": {"template":{"spec":{"containers": [{"name":"xxxxx", "resources": {"limits": {"cpu": "100m","memory": "50Mi"},"requests": {"cpu": "100m","memory": "50Mi"}}}]}}}}'


kubectl patch daemonset catalog-ui --patch '{"spec": {"template":{"spec":{"containers":[{"resources":{"limits":"hcmCapabilityEnabled","value":"true"},{"name":"hcmRedirectUrl","value":"https://'${CLUSTER_IP}':8443/hcmconsole/remoteinstall"}]}]}}}}' -n kube-system


spec
containers
resources
limits
