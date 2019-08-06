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

cfssl gencert -ca=/etc/kubernetes/pki/ca.crt -ca-key=/etc/kubernetes/pki/ca.key -config=ca-config.json -profile=kubernetes devuser-csr.json | cfssljson -bare devuser