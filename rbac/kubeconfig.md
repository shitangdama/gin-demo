#kubeconfig是什么？

kubeconfig主要是用于健全

k8s apiserver是双向tls鉴权
kubeconfig先表明了user,然后是tls的公私钥
以及默认的context

- 关于集群参数
    本段设置了所需要访问的集群的信息。
    --certificate-authority-data设置了该集群的公钥

- 用户参数
    本段主要设置用户的相关信息，主要是用户证书。
    ca认证，关于token认证。

- 上下文参数
    集群参数和用户参数可以同时设置多对，在上下文参数中将集群参数和用户参数关联起来。上面的上下文名称为kubenetes，集群为kubenetes，用户为admin，表示使用admin的用户凭证来访问kubenetes集群的default命名空间，也可以增加--namspace来指定访问的命名空间。

所以这里使用client需要kubeconfig来做双向tls
通过kubeconfig来创建client，client来请求api
kubectl简化了操作

研究下中间的ca和token
# 替换host
# vi /etc/hosts
...
118.31.xo.xo  dev-7

这里是不是要从新签发证书
cfssl-cert或openssl查看过期时间
kubeadm里面存在过期问题

使用kubeadm创建完Kubernetes集群后, 默认会在/etc/kubernetes/pki目录下存放集群中需要用到的证书文件。

集群参数
kubectl config set-cluster kubernetes \
  --certificate-authority=/etc/kubernetes/pki/ca.pem \
  --embed-certs=true \
  --server=https://dama_api.datayang.com \
  --kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf

客户端认证参数
kubectl config set-credentials kubernetes-admin \
  --client-certificate=/etc/kubernetes/pki/admin.pem \
  --embed-certs=true \
  --client-key=/etc/kubernetes/ssl/admin-key.pem

设置上下文参数
上下文参数将集群参数和用户参数关联起来。如上面的上下文名称为kubenetes，集群为kubenetes，用户为admin，表示使用admin的用户凭证来访问kubenetes集群的default命名空间，也可以增加--namspace来指定访问的命名空间。
kubectl config set-context kubernetes \
  --cluster=kubernetes \
  --user=admin
  <!-- --namespace -->

设置默认上下文
最后使用kubectl config use-context kubernetes来使用名为kubenetes的环境项来作为配置。如果配置了多个环境项，可通过切换不同的环境项名字来访问到不同的集群环境。
kubectl config use-context kubernetes

关于用户的kubeconfig


# For kubeadm provisioned clusters
kubeadm alpha certs check-expiration

# For all clusters
openssl x509 -noout -dates -in /etc/kubernetes/pki/apiserver.crt

证书轮换
https://feisky.gitbooks.io/kubernetes/practice/certificate-rotation.html

这里序号额外的的ca来处理？

/etc/kubernetes/manifests 作为 kubelet 寻找静态 Pod 的路径。静态 Pod 清单的名称是：
etcd.yaml
kube-apiserver.yaml
kube-controller-manager.yaml
kube-scheduler.yaml
/etc/kubernetes/ 作为存储具有控制平面组件标识的 kubeconfig 文件的路径。kubeconfig 文件的名称是：
kubelet.conf （bootstrap-kubelet.conf - 在 TLS 引导期间）
controller-manager.conf
scheduler.conf
admin.conf 用于集群管理员和 kubeadm 本身

证书和密钥文件的名称：
ca.crt，ca.key 为 Kubernetes 证书颁发机构
apiserver.crt，apiserver.key 用于 API server 证书
apiserver-kubelet-client.crt，apiserver-kubelet-client.key 用于由 API server 安全地连接到 kubelet 的客户端证书
sa.pub，sa.key 用于签署 ServiceAccount 时控制器管理器使用的密钥
front-proxy-ca.crt，front-proxy-ca.key 用于前台代理证书颁发机构
front-proxy-client.crt，front-proxy-client.key 用于前端代理客户端

研究下openssl和cfssl