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