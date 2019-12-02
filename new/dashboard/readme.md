kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin | awk '{print $1}')

kubectl describe secret/$(kubectl get secret -n kube-system |grep kubernetes-dashboard|awk '{print $1}') -n kube-system