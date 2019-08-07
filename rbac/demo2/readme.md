#重新启动


sudo kubeadm init --kubernetes-version=1.15.0 \
<!-- --image-repository registry.aliyuncs.com/google_containers \ -->
--image-repository registry.cn-hangzhou.aliyuncs.com/google_containers
--service-cidr=10.1.0.0/16 \
--pod-network-cidr=192.168.0.0/16 \
--ignore-preflight-errors=Swap

kubeadm alpha certs renew all --config /etc/kubernetes/kubeadm-config.yaml

kubeadm alpha certs renew all --config ./kubeadm-config.yaml

kubeadm alpha certs renew apiserver --config ./kubeadm-config.yaml

kubeadm init phase certs apiserver --config ./kubeadm-config.yaml
kubeadm init phase certs apiserver-kubelet-client --config ./kubeadm-config.yaml

kubeadm init phase kubeconfig all --config ./kubeadm-config.yaml
kubeadm alpha phase kubeconfig all

更换证书
删除所有的

完成上方操作后，docker restart重启kube-apiserver,kube-controller,kube-scheduler这3个容器

k8s_POD_kube-apiserver-shitangdama-latitude-3440_kube-system_8e1c9da373935b774b783f1ae2b88365_1

k8s_POD_kube-controller-manager-shitangdama-latitude-3440_kube-system_82469f85ab5a0c80d7b77f961a75e7e3_1

k8s_POD_kube-scheduler-shitangdama-latitude-3440_kube-system_72815ad5dd205fae43f0c83b411ccbb6_3