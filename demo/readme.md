关于测试

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
kubectl describe deployments auth

kubectl create configmap nginx-frontend-conf --from-file=nginx/frontend.conf
kubectl create -f deployments/frontend.yaml
kubectl create -f services/frontend.yaml
kubectl get services frontend

curl -k https://localhost