#从新安装
- 确保client链接
- 可以链接，主要问题是apiserver的证书

sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X

If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
to reset your system's IPVS tables.

apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

sudo kubeadm init --config ./kubeadm-config.yaml

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

关于calico
kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml

cat <<EOF > /etc/sysctl.d/k8s.conf
  net.ipv4.ip_forward = 1
  net.bridge.bridge-nf-call-ip6tables = 1
  net.bridge.bridge-nf-call-iptables = 1
EOF

$ sysctl -p /etc/sysctl.d/k8s.conf
3.3 配置host文件
#配置host，使每个Node都可以通过名字解析到ip地址
$ vi /etc/hosts
#加入如下片段(ip地址和servername替换成自己的)
192.168.1.101 server01

重启
kubectl scale deployment chat --replicas=0 -n service

#容忍
kubectl taint nodes --all node-role.kubernetes.io/master-

#对应helm的权限
kubectl apply -f helm-rbac.yaml

helm init --service-account tiller --tiller-image registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.14.1 --skip-refresh --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

kubectl apply -f nginx-ingress.yaml
kubectl apply -f service-nodeport.yaml

kubectl apply -f kubernetes-dashboard.yaml

我已经替换了dns
<!-- #这里临时替换dns -->
<!-- kubectl apply -f cert-manager.yaml -n cert-manager -->

<!-- kubectl apply -f production-issuer.yaml 
kubectl delete -f production-issuer.yaml 
kubectl describe issuer letsencrypt-prod -->

kubectl apply -f production-issuer_system.yaml
kubectl delete -f production-issuer_system.yaml
kubectl describe issuer letsencrypt-prod

helm del --purge cert-manager

kubectl apply -f dashboard_ingress_system.yaml
kubectl delete -f dashboard_ingress_system.yaml



<!-- kubectl logs --tail=20 nginx-ingress-controller-7f4b7d7b5f-sbslm -n ingress-nginx

kubectl logs --tail=20 cert-manager-54dffbdd8b-5hxwn   -n cert-manager

kubectl logs --tail=20 cert-manager-cainjector-7688bf9689-rth56 -n cert-manager -->
<!-- kubectl logs --tail=20 cert-manager-webhook-dfcbcc64b-knnxt -n cert-manager -->


kubectl get issuer -A
kubectl get cert -A
kubectl get order -A

order是什么资源

这里还需要调整

#登陆

kubectl create -f admin-role.yml

kubectl -n kube-system describe secret admin-token

<!-- https://rootsongjc.gitbooks.io/kubernetes-handbook/guide/kubectl-user-authentication-authorization.html


helm install stable/kubernetes-dashboard -n kubernetes-dashboard --namespace kube-system -->