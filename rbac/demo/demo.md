#测试创建用户授权kubeconfig

client certificate： 用于服务端认证客户端,例如etcdctl、etcd proxy、fleetctl、docker客户端
server certificate: 服务端使用，客户端以此验证服务端身份,例如docker服务端、kube-apiserver
peer certificate: 双向证书，用于etcd集群成员间通信

这里openssl和cfssl证书问题


需要这四个文件
ca-key.pem  ca.pem ca-config.json  devuser-csr.json

进行转换
/etc/kubernetes/pki/ca.crt 证书
/etc/kubernetes/pki/ca.key 私钥

cfssl gencert -ca=/etc/kubernetes/pki/ca.crt -ca-key=/etc/kubernetes/pki/ca.key -config=ca-config.json -profile=kubernetes admin-csr.json | cfssljson -bare admin

产生
admin.csr  admin-key.pem  admin.pem

# 设置集群参数
kubectl config set-cluster kubernetes \
--certificate-authority=/etc/kubernetes/pki/ca.crt \
--embed-certs=true \
--server=https://dama_api.datayang.com \
--kubeconfig=admin.kubeconfig 

kubeconfig 设置地址

# 设置客户端认证参数
kubectl config set-credentials kubernetes-admin \
--client-certificate=/etc/kubernetes/pki/user/admin.pem \
--client-key=/etc/kubernetes/pki/user/admin-key.pem \
--embed-certs=true \
--kubeconfig=admin.kubeconfig

# 设置上下文参数
kubectl config set-context kubernetes-admin@kubernetes \
--cluster=kubernetes \
--user=kubernetes-admin \
--kubeconfig=admin.kubeconfig
<!-- --namespace=dev \ -->
# 设置默认上下文
kubectl config use-context kubernetes-admin@kubernetes --kubeconfig=admin.kubeconfig


在创建一个账号和kubernetes-admin一样

