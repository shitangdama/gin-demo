#监控

安装 metrics server

kubectl create -f ./metrics/

kubectl -n kube-system get pods -l k8s-app=metrics-server

kubectl describe metrics-server-6d7c9596cb-n27dl -n kube-system