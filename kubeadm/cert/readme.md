# Install the CustomResourceDefinition resources separately
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.11.0/cert-manager.yaml



# Install the CustomResourceDefinition resources separately
kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.11/deploy/manifests/00-crds.yaml

kubectl apply --validate=false -f ./00-crds.yaml


kubectl delete -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.11/deploy/manifests/00-crds.yaml
# Create the namespace for cert-manager
kubectl create namespace cert-manager

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install --generate-name --namespace cert-manager --version v0.11.0 jetstack/cert-manager
helm install --name-template cert-manager --namespace cert-manager jetstack/cert-manager

kubectl run -it --rm --image=infoblox/dnstools dns-client

helm del --purge cert-manager


重启
kubectl get pod PODNAME -n NAMESPACE -o yaml | kubectl replace --force -f -


helm install --generate-name --namespace cert-manager --version v0.11.0 jetstack/cert-manager

helm install --generate-name --namespace cert-manager  jetstack/cert-manager


删除

kubectl get ns cert-manager  -o json > temp.json

curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json https://192.168.123.142:8080/api/v1/namespaces/cert-manager/finalize

curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json https://192.168.123.142:8081/api/v1/namespaces/cert-manager/finalize

强制删除namespace
https://my.oschina.net/xxbAndy/blog/3120332