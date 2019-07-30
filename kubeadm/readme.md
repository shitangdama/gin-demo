安装

#安装kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/linux/amd64/kubectl

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl

kubectl version

安装 kubeadm， kubelet 

```
    # sudo apt-get update && apt-get install -y apt-transport-https
    # sudo curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
    # sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
    deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
    EOF  
    # sudo apt-get update
    # apt-get install -y kubectl kubelet kubeadm
```


Enabling shell autocompletion

sudo kubeadm init --kubernetes-version=1.15.0 \
<!-- --image-repository registry.aliyuncs.com/google_containers \ -->
--image-repository registry.cn-hangzhou.aliyuncs.com/google_containers
--service-cidr=10.1.0.0/16 \
--pod-network-cidr=192.168.0.0/16 \
--ignore-preflight-errors=Swap

关于calico
kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml

关于dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

docker tag  registry.cn-hangzhou.aliyuncs.com/google_containers/kubernetes-dashboard-amd64:v1.10.1 k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.1