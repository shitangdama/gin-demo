#进阶部署
helm和ingress
测试minikube的nginx-ingress

部署nignx-ingress

启动echo server

minikube addons enable ingress

创建ingress

kubectl run echoserver --image=registry.cn-hangzhou.aliyuncs.com/google-containers/echoserver:1.4 --port=8080
kubectl expose deployment echoserver --type=NodePort
kubectl get pod
minikube service echoserver --url

curl $(minikube service echoserver --url)

解决minikube启动时候docker镜像问题
docker pull registry.cn-hangzhou.aliyuncs.com/google-containers/echoserver:1.4
docker tag  registry.cn-hangzhou.aliyuncs.com/google-containers/echoserver:1.4 gcr.io/google-containers/echoserver:1.4

minikube没有rbac

kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
harbor

安装helm

$ curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
$ chmod 700 get_helm.sh
$ ./get_helm.sh

# 配置阿里云镜像安装并把默认仓库设置为阿里云上的镜像仓库
$ helm init --upgrade --tiller-image registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.14.2 --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

如何设置pv和pvc

关于 k8s mysql pv pvc nfs 编排



本地pv

使用nfs


使用nfs部署mysql

使用s