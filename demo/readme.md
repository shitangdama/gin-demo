关于测试

kubectl replace --force -f pods/hello-flask-app.yaml


cat pods/monolith.yaml
kubectl create -f pods/monolith.yaml
kubectl get pods
kubectl describe pods monolith

kubectl port-forward monolith 10080:80
curl http://127.0.0.1:10080
curl http://127.0.0.1:10080/secure

curl -u user http://127.0.0.1:10080/login

curl -H "Authorization: Bearer <token>" http://127.0.0.1:10080/secure

kubectl logs monolith

kubectl exec monolith --stdin --tty -c monolith /bin/sh

curl http://127.0.0.1:10080
splunk
Cloudera

paramiko

关于secret 和 configmap

ls tls
kubectl create secret generic tls-certs --from-file=tls/
kubectl describe secrets tls-certs
kubectl create configmap nginx-proxy-conf --from-file=nginx/proxy.conf
kubectl describe configmap nginx-proxy-conf

cat pods/secure-monolith.yaml
kubectl create -f pods/secure-monolith.yaml
kubectl get pods secure-monolith
kubectl port-forward secure-monolith 10443:443

curl --cacert tls/ca.pem https://127.0.0.1:10443
kubectl logs -c nginx secure-monolith

cat services/monolith.yaml
kubectl create -f services/monolith.yaml

关于deployment

cat deployment/auth.yaml

kubectl create -f deployments/auth.yaml
kubectl create -f services/auth.yaml
kubectl create -f deployments/hello.yaml
kubectl create -f services/hello.yaml

kubectl describe deployments auth

kubectl create secret generic tls-certs --from-file=tls/
kubectl create configmap nginx-frontend-conf --from-file=nginx/frontend.conf
kubectl create -f deployments/frontend.yaml
kubectl create -f services/frontend.yaml
kubectl get services frontend

curl -k https://localhost

EXTERNAL-IP会有问题
使用minikube ssh进入内部可直接使用内网ip
使用ingress
https://stackoverflow.com/questions/39850819/kubernetes-minikube-external-ip-does-not-work