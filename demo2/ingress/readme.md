kubectl create -f dashboard_ingress.yaml

echo "$(minikube ip) dashboard.shitangdama.cn" | sudo tee -a /etc/hosts