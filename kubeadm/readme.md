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

关于设置hostnetwork: true

kubectl describe secret -n kube-system dashboard-admin-token

关于容忍
kubectl taint nodes --all node-role.kubernetes.io/master-

helm 中的rbac
https://helm.sh/docs/using_helm/#role-based-access-control


注意helm的server版本和client版本
不一致需要删除对应的client的deploy和svc，server中的.helm
helm init --service-account tiller --tiller-image registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.14.1 --skip-refresh --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

scp -P 6000 helm-v2.14.1-linux-amd64.tar.gz  shitangdama@118.24.133.253:/home/shitangdama/gin-demo/kubeadm 

<!-- helm install stable/nginx-ingress \
-n nginx-ingress \
--namespace ingress-nginx -->

helm install stable/nginx-ingress -f nginx-ingress.yaml -n nginx-ingress --namespace nginx-ingress

会有权限问题

helm del --purge kubernetes-dashboard
helm install stable/kubernetes-dashboard -n kubernetes-dashboard --namespace kube-system

default-backend.yaml为什么没有了


cert-manager 签发证书

<!-- helm install \
    --name cert-manager \
    --namespace kube-system \
    stable/cert-manager


这里配置又一个问题

k8s提供Issuer跟ClusterIssuer两种，前者是单一namespace使用，后者是cluster wide也就是每個namespace都可以reference到。 需要创建一个ClusterIssuer -->

写的教程有问题
对比中英的比较

初始化的一个又一个yaml可以学习？

CustomResourceDefinitions是什么？

流程
```
# Install the cert-manager CRDs. We must do this before installing the Helm
# chart in the next step for `release-0.8` of cert-manager:
$ kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.8/deploy/manifests/00-crds.yaml

# Create the namespace for cert-manager
$ kubectl create namespace cert-manager

## IMPORTANT: if the cert-manager namespace **already exists**, you MUST ensure
## it has an additional label on it in order for the deployment to succeed
$ kubectl label namespace cert-manager certmanager.k8s.io/disable-validation="true"

## Add the Jetstack Helm repository
$ helm repo add jetstack https://charts.jetstack.io
## Updating the repo just incase it already existed
$ helm repo update

## Install the cert-manager helm chart
$ helm install \
  --name cert-manager \
  --namespace cert-manager \
  --version v0.8.1 \
  jetstack/cert-manager
```
helm del --purge cert-manager
文档和blog差距比较大
还是要重读一遍文档

kubectl apply -f production-issuer.yaml 
kubectl delete -f production-issuer.yaml 
kubectl describe issuer letsencrypt-prod

kubectl apply -f staging-issuer.yaml 
kubectl delete -f staging-issuer.yaml 
kubectl describe issuer letsencrypt-staging

kubectl apply -f cert-manager.yaml -n cert-manager
一定要查看下状态，可能timeout
 $ kubectl describe issuer letsencrypt-prod

 nslookup https://acme-staging-v02.api.letsencrypt.org/directory

 这里kubedns
 kubectl logs cert-manager-68545dc6b7-dg4db  -n cert-manager
 kubectl exec -it -n cert-manager cert-manager-54dffbdd8b-lpwt7 /bin/bash