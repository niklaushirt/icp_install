

ssh root@94.23.25.93

kubectl delete LimitRange -n default mem-limit-range




kubectl apply -n kube-system -f policies.yaml
kubectl apply -n kube-system -f policies-pp.yaml
kubectl apply -n kube-system -f policies-pb.yaml



kubectl delete -n kube-system -f policies.yaml
kubectl delete -n kube-system -f policies-pp.yaml
kubectl delete -n kube-system -f policies-pb.yaml