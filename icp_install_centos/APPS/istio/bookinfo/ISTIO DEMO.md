# ISTIO DEMO

## Injection
```bash
kubectl label namespace default istio-injection=enabled
kubectl label namespace cert-manager istio-injection=enabled
kubectl get ns --show-labels
```


## Test Loop
```bash
for i in `seq 1 200000`; do curl http://$(hostname --ip-address):31380/productpage; done
```

## Vaalidation 
```bash
kubectl delete Gateway -n default bookinfo-gateway

kubectl apply --namespace default -f ~/INSTALL/APPS/istio/istio/samples/bookinfo/networking/bookinfo-gateway.yaml
```

## All to V1
```bash
kubectl apply --namespace default -f ~/INSTALL/APPS/istio/bookinfo/book_all_v1.yaml
```

```yaml
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
  - reviews
  http:
  - route:
    - destination:
        host: reviews
        subset: v1
```

## 50/50 V1/V2
```bash
kubectl apply --namespace default -f ~/INSTALL/APPS/istio/bookinfo/book_50.yaml
```


```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
    - reviews
  http:
  - route:
    - destination:
        host: reviews
        subset: v1
      weight: 50
    - destination:
        host: reviews
        subset: v2
      weight: 50
```

## Manual Edit
```bash
KUBE_EDITOR="nano" kubectl  edit virtualservice reviews --namespace default
```

## V3 for Jason
```bash
kubectl apply --namespace default -f ~/INSTALL/APPS/istio/bookinfo/book_jason.yaml
```

```yaml
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
  - reviews
  http:
  - match:
    - headers:
        end-user:
          exact: jason
    route:
    - destination:
        host: reviews
        subset: v3
  - route:
    - destination:
        host: reviews
        subset: v2
```



## Deny
```bash
kubectl apply --namespace default -f ~/INSTALL/APPS/istio/bookinfo/book_deny_v2.yaml
```

```yaml
...
kind: rule
metadata:
  name: denyreviewsv2
spec:
  match: destination.labels["app"] == "ratings" && source.labels["app"]=="reviews" && source.labels["version"] == "v2"
  actions:
  - handler: denyreviewsv2handler.denier
    instances: [ denyreviewsv2request.checknothing ]
...
```




## Delete Demo
```bash

kubectl delete --namespace default -f ~/INSTALL/APPS/istio/bookinfo/book_deny_v2.yaml
kubectl delete --namespace default -f ~/INSTALL/APPS/istio/bookinfo/book_jason.yaml
kubectl delete --namespace default -f ~/INSTALL/APPS/istio/bookinfo/book_50.yaml
kubectl delete --namespace default -f ~/INSTALL/APPS/istio/bookinfo/book_all_v1.yaml
kubectl apply --namespace default -f ~/INSTALL/APPS/istio/bookinfo/destination-rule-all.yaml



kubectl delete --namespace default -f ~/INSTALL/APPS/istio/bookinfo/destination-rule-all.yaml

kubectl delete --namespace default -f ~/INSTALL/APPS/istio/bookinfo/bookinfo-gateway.yaml

kubectl delete --namespace default -f ~/INSTALL/APPS/istio/bookinfo/bookinfo.yaml

```
