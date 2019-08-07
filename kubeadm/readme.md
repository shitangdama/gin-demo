#从新安装
- 确保client链接
- 可以链接，主要问题是apiserver的证书

apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

sudo kubeadm init --config ./kubeadm-config.yaml

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

关于calico
kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml


#容忍
kubectl taint nodes --all node-role.kubernetes.io/master-

#对应helm的权限

helm init --service-account tiller --tiller-image registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.14.1 --skip-refresh --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts


kubectl apply -f nginx-ingress.yaml
kubectl apply -f service-nodeport.yaml

#cert-manager
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.8/deploy/manifests/00-crds.yaml
kubectl create namespace cert-manager
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation="true"

helm install \
  --name cert-manager \
  --namespace cert-manager \
  --version v0.8.1 \
  jetstack/cert-manager

#这里临时替换dns
kubectl apply -f cert-manager.yaml -n cert-manager

kubectl apply -f production-issuer.yaml 
kubectl delete -f production-issuer.yaml 
kubectl describe issuer letsencrypt-prod

kubectl apply -f production-issuer_v1.yaml
kubectl delete -f production-issuer_v1.yaml
kubectl describe issuer letsencrypt-prod

kubectl apply -f dashboard_ingress_v1.yaml
kubectl delete -f dashboard_ingress_v1.yaml

kubectl apply -f dashboard_ingress_v3.yaml
kubectl delete -f dashboard_ingress_v3.yaml

kubectl apply -f dashboard_ingress.yaml
kubectl delete -f dashboard_ingress.yaml


kubectl logs --tail=20 nginx-ingress-controller-7f4b7d7b5f-ds6w8 -n ingress-nginx

kubectl logs --tail=20 cert-manager-68545dc6b7-59g4n -n cert-manager

kubectl logs --tail=20 cert-manager-cainjector-7688bf9689-rth56 -n cert-manager
<!-- kubectl logs --tail=20 cert-manager-webhook-dfcbcc64b-knnxt -n cert-manager -->


kubectl get issuer -A
kubectl get cert -A