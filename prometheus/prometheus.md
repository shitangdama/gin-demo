使用metric-server收集数据给k8s集群内使用，如kubectl,hpa,scheduler等
使用prometheus-operator部署prometheus，存储监控数据
使用kube-state-metrics收集k8s集群内资源对象数据
使用node_exporter收集集群中各节点的数据
使用prometheus收集apiserver，scheduler，controller-manager，kubelet组件数据
使用alertmanager实现监控报警
使用grafana实现数据可视化

二进制安装启动时添加如下参数 –address=0.0.0.0

如果使用kubeadm启动的集群，初始化时加入如下参数
controllerManagerExtraArgs:
  address: 0.0.0.0
schedulerExtraArgs:
  address: 0.0.0.0


如果是已经启动之后的集群，可以使用如下命令修改
sudo sed -e "s/- --address=127.0.0.1/- --address=0.0.0.0/" -i /etc/kubernetes/manifests/kube-controller-manager.yaml
sudo sed -e "s/- --address=127.0.0.1/- --address=0.0.0.0/" -i /etc/kubernetes/manifests/kube-scheduler.yaml

收集kubelet相关数据时需要配置kubelet使用如下认证方式。使用kubeadm默认情况下已经开启
--authentication-token-webhook=true
--authorization-mode=Webhook


kubectl cluster-info

prometheus-operator

