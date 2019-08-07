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

#对应helm的权限

helm init --service-account tiller --tiller-image registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.14.1 --skip-refresh --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts