#关于命名空间
default：你的service和app默认被创建于此。
kube-system：kubernetes系统组件使用。
kube-public：公共资源使用。但实际上现在并不常用。

```
    kubectl create namespace test
    kubectl get namespace
```
进行转化当前namespace
kubens

##跨namespace通信

命名空间彼此是透明的。但它们并不是绝对相互隔绝但。一个namespace中service可以和另一个namespace中的service通信。这非常有用，比如你团队的一个service要和另外一个团队的service通信，而你们的service都在各自的namespace中。
<Service Name>.<Namespace Name>.svc.cluster.local

一般情况下，你只需要service的名称，DNS会自动解析到它的全地址。然而，如果你要访问其他namespace中的service，那么你就需要同时使用service名称和namespace名称。
例如，你想访问test中的“database”服务，你可以使用下面的地址：
database.test

#关于权限的学习

四个概念 Role、ClusterRole、RoleBinding、ClusterRoleBinding。

和namesapce什么关系

role只能在一个namespace中获取资源

clusterrole 可以跨namespace
- 集群范围的资源，例如Node
- 非资源型的路径，例如/healthz
- 包含全部命名空间的资源，例如pods

kubectl describe secrets $(kubectl get secrets -n kube-system |grep admin |cut -f1 -d ' ') -n kube-system |grep -E '^token' |cut -f2 -d':'|tr -d '\t'|tr -d ' '
# 将TOken设成环境变量
 TOKEN=$(kubectl describe secrets $(kubectl get secrets -n kube-system |grep admin |cut -f1 -d ' ') -n kube-system |grep -E '^token' |cut -f2 -d':'|tr -d '\t'|tr -d ' ')
# 获取APIserver的地址端口
kubectl config view |grep server|cut -f 2- -d ":" | tr -d " "
# 将APIserver的地址端口设置环境变量
APISERVER=$(kubectl config view |grep server|cut -f 2- -d ":" | tr -d " ")
通过设置HTTP标头，通过Token认证访问APIserver

curl -H "Authorization: Bearer $TOKEN" $APISERVER/api  --insecure