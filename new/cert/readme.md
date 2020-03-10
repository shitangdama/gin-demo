# 从新安装0.12版本问题

1. Install the CustomResourceDefinition resources separately

kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.12/deploy/manifests/00-crds.yaml

2. Create the namespace for cert-manager

kubectl create namespace cert-manager

Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

Update your local Helm chart repository cache

helm repo update

helm install --name-template cert-manager --namespace cert-manager --version v0.12.0 jetstack/cert-manager



kubectl run -it --rm --image=infoblox/dnstools dns-client --overrides='{"spec": {"nodeSelector": { "name": "node2" }}}'