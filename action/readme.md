关于tls证书问题
https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/


kubectl 别名
alias k=kubectl

pod的日志达到10mb大小时候，容器日志会自动论题，kubectl logs 命令进现实最后一次轮替后的日志条目。

重启后容器获取之前日志
kubectl logs mypod --previous

标签
注解
命名空间

切换 namespace
alias kcd='kubectl config set-context $(kubectl config current-context) --namespace' 

<!-- sudo ifconfig eth0 down  -->
kubectl label pod/pods
修改pod模版只会影响之后创建的pod

kubectl scale

daemonset

kubectl exec kxxxxx -- curl -s http://10.121.32.12

--之后是内部命令

server里面是否有亲和
sesseionaffinity：client

kubectl exec kxxx env

fqdn权限定域名

backend-database.default.svc.cluster.local
backend-database 服务名称
default命名空间
svc.cluster.loacl集群后缀

查看容器中的
cat /etc/resolv.conf

一种对外暴露
endpoint 
不是很理解
https://www.ccieliu.com/k8s/35.html

loadbalance

loadbalancer和ingress区别
loadbalancer要求公网ip
ingress只需要1个

kubectl exec dnsutils nslookup kuba-headless

kubernetes downward api

发现伙伴节点dns

拜占庭将军

veth pair
https://blog.csdn.net/LL845876425/article/details/82156405
https://blog.csdn.net/chengqiuming/article/details/80113659

iptable的转换

复习点
stateful
各个工具的源码
调试工具
三位一体
