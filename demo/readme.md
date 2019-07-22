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

curl http://127.0.0.1:10080