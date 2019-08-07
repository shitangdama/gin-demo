#之前做法有问题

之前是声明用户的ca
但是不是远端的ca

http://dockone.io/article/8807

感觉应该是动上面的ca
上面的ca来自于

https://rootsongjc.gitbooks.io/kubernetes-handbook/content/practice/create-tls-and-secret-key.html

从新生成key

ca不动，

sudo kubeadm alpha phase certs apiserver

https://github.com/kubernetes/kubeadm/issues/581

sudo kubeadm alpha certs apiserver


是不是ca证书问题

在 kube-apiserver 中, 一般明确指定用于 https 访问的服务端证书和带有CN 用户名信息的客户端证书. 而在 kubelet 的启动配置中, 一般只指定了 ca 根证书, 而没有明确指定用于 https 访问的服务端证书, 这是因为, 在生成服务端证书时, 一般会指定服务端地址或主机名, kube-apiserver 相对变化不是很频繁, 所以在创建集群之初就可以预先分配好用作 kube-apiserver 的 IP 或主机名/域名, 但是由于部署在 node 节点上的 kubelet 会因为集群规模的变化而频繁变化, 而无法预知 node 的所有 IP 信息, 所以 kubelet 上一般不会明确指定服务端证书, 而是只指定 ca 根证书, 让 kubelet 根据本地主机信息自动生成服务端证书并保存到配置的cert-dir文件夹中.


先更新kube-apiserver，感觉ca没有问题

关于更新证书

https://www.cnblogs.com/aguncn/p/10399055.html

$ sudo mv /etc/kubernetes/pki/apiserver.key /etc/kubernetes/pki/apiserver.key.old
$ sudo mv /etc/kubernetes/pki/apiserver.crt /etc/kubernetes/pki/apiserver.crt.old
$ sudo mv /etc/kubernetes/pki/apiserver-kubelet-client.crt /etc/kubernetes/pki/apiserver-kubelet-client.crt.old
$ sudo mv /etc/kubernetes/pki/apiserver-kubelet-client.key /etc/kubernetes/pki/apiserver-kubelet-client.key.old
$ sudo mv /etc/kubernetes/pki/front-proxy-client.crt /etc/kubernetes/pki/front-proxy-client.crt.old
$ sudo mv /etc/kubernetes/pki/front-proxy-client.key /etc/kubernetes/pki/front-proxy-client.key.old

不对，是ca问题，在设置
--certificate-authority=/etc/kubernetes/pki/ca.crt \

这个有问题