#从新安装
- 确保client链接
- 可以链接，主要问题是apiserver的证书

sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X

kubeadm config images pull

If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
to reset your system's IPVS tables.

sudo curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -

apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl


需要现在host中加入node

sudo kubeadm init --config ./kubeadm-config.yaml


kubeadm config migrate --old-config ./kubeadm-config.yaml --new-config new.yaml


kubeadm join 192.168.123.142:6443 --token yles1l.c3tju7c0lnsaoury --discovery-token-ca-cert-hash sha256:d29af2825a6d4c0f5f695802c41c08a170655b3add5855e304d965e0a353ebc8

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

关于calico
kubectl apply -f https://docs.projectcalico.org/v3.9/manifests/calico.yaml

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
node-role.kubernetes.io/master=

helm 3.0


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

 eyJhbGciOiJSUzI1NiIsImtpZCI6InBkclFobWNWU3A5TFR2S0dadVdYeExYQ21KeWxLVmFqaklNZTFvbTkzMmsifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi10b2tlbi1wZHg4dCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJhZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijc2Y2Y5YjFlLTc5NjYtNDljMi05NGE0LTA0MmU3N2FmOGE0MiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTphZG1pbiJ9.X0OC9g98we107QzW4MSukKLWiVL892FmY0alyxs74c8OXwxmkvW6936VYuQIspI0jOgqSHsEi2TX4cKcmdJsJQ8glfDvrqZW8NVKp0sPhtNBWsSQcFMhEa3hJNdVljpL7XZDgBxmq9vwhTz6XhHvrfUNwSER8r1sje-3TLOxFxGYTHQJtxkZecfsPuIJXeWON3ekk8bFrpRJVgcdrOFXGG2wd72kEi62iPj32BzclOBvY3yxRLsltj9lB8uMWHzPM7AKkfhr5xTP_w_GHl_qCQ11RTQBxkV_bkhqMfe99nYoOKsJT_POtPprkkHU05Y6S-P3jgek5eAQ_9m9daut3A

 --node-name string                              Specify the node name.

 kubeadm config print init-defaults --component-configs KubeProxyConfiguration
 查看默认配置
 kubeadm join 192.168.123.142:6443 --token ne2a1x.huxa0hjzhuxhzoip --discovery-token-ca-cert-hash sha256:b6237c99d0fc1e93bd852b1d34a0a0161a77122193e06f655e6b764a9e1d0758 --node-name node2

helm fetch stable/jenkins
helm template . --name istio-init --namespace istio-system > istio-init.yaml