#重新启动


sudo kubeadm init --kubernetes-version=1.15.0 \
<!-- --image-repository registry.aliyuncs.com/google_containers \ -->
--image-repository registry.cn-hangzhou.aliyuncs.com/google_containers
--service-cidr=10.1.0.0/16 \
--pod-network-cidr=192.168.0.0/16 \
--ignore-preflight-errors=Swap

kubeadm alpha certs renew all --config /etc/kubernetes/kubeadm-config.yaml

kubeadm alpha certs renew all --config /etc/kubernetes/kubeadm-config.yaml