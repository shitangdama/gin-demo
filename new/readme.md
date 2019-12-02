迁移过来新的文档

总结问题

最主要问题是在ub环境下的dns问题

sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X

sudo kubeadm init --config ./kubeadm-config.yaml

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml
<!-- dns wenti -->
https://blog.csdn.net/u011663005/article/details/87937800

kubectl label node node1 node-role.kubernetes.io/node=
kubectl label node node2 node-role.kubernetes.io/node=

kubectl taint nodes --all node-role.kubernetes.io/master-

kubectl taint nodes node1 node-role.kubernetes.io/master=:NoSchedule
kubectl taint nodes node1 node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes node1 node.kubernetes.io/unreachable:NoSchedule-

kubeadm token create --print-join-command

kubeadm join 192.168.123.142:6443 --token 85e3cw.vjhe7nm0s3dnfg2u --discovery-token-ca-cert-hash sha256:41d4e0ed2ebd4f4a2854605f84ab4181a7dc3d41b4d6432503e6baf896516253 --node-name node2


kubectl apply -f ./ingress/nginx-ingress.yaml
kubectl apply -f ./ingress/service-nodeport.yaml

sudo ETCDCTL_API=3 etcdctl --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/peer.crt --key=/etc/kubernetes/pki/etcd/peer.key get / --prefix --keys-only | grep node1 | xargs -I {} etcdctl rm {}

sudo ETCDCTL_API=3 etcdctl --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/peer.crt --key=/etc/kubernetes/pki/etcd/peer.key del


# 删除POD
kubectl delete pod PODNAME --force --grace-period=0

# 删除NAMESPACE
kubectl delete namespace NAMESPACENAME --force --grace-period=0

若以上方法无法删除，可使用第二种方法，直接从ETCD中删除源数据
# 删除default namespace下的pod名为pod-to-be-deleted-0
ETCDCTL_API=3 etcdctl del /registry/pods/default/pod-to-be-deleted-0

# 删除需要删除的NAMESPACE
etcdctl del /registry/namespaces/NAMESPACENAME
