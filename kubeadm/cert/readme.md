# Install the CustomResourceDefinition resources separately
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.11/deploy/manifests/00-crds.yaml
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.10.1/cert-manager.yaml
# Create the namespace for cert-manager
kubectl create namespace cert-manager

# Label the cert-manager namespace to disable resource validation
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install --name cert-manager --namespace cert-manager --version v0.11 jetstack/cert-manager
helm install --name cert-manager --namespace cert-manager --version v0.10.1 jetstack/cert-manager

kubectl run -it --rm --image=infoblox/dnstools dns-client

helm del --purge cert-manager


重启
kubectl get pod PODNAME -n NAMESPACE -o yaml | kubectl replace --force -f -