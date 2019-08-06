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

#建立监控命名空间
kubectl create namespace monitoring

#clone
https://github.com/coreos/kube-prometheus

mkdir serviceMonitor operator grafana kube-state-metrics alertmanager node-exporter adapter prometheus
mv *-serviceMonitor* serviceMonitor/
mv 0prometheus-operator* operator/
mv grafana-* grafana/
mv kube-state-metrics-* kube-state-metrics/
mv alertmanager-* alertmanager/
mv node-exporter-* node-exporter/
mv prometheus-adapter-* adapter/
mv prometheus-* prometheus/

kubectl apply -f 00namespace-namespace.yaml


kubectl apply -f operator/
kubectl get pods -n monitoring

#全部部署

kubectl apply -f adapter/
kubectl apply -f alertmanager/
kubectl apply -f node-exporter/
kubectl apply -f grafana/
kubectl apply -f prometheus/
kubectl apply -f serviceMonitor/
kubectl apply -f kube-state-metrics/

kubectl get all -n monitoring

使用metric-server收集数据给k8s集群内使用，如kubectl,hpa,scheduler等
使用prometheus-operator部署prometheus，存储监控数据
使用kube-state-metrics收集k8s集群内资源对象数据
使用node_exporter收集集群中各节点的数据
使用prometheus收集apiserver，scheduler，controller-manager，kubelet组件数据
使用alertmanager实现监控报警
使用grafana实现数据可视化

kubectl apply -f ingress-all-svc.yml
kubectl delete -f ingress-all-svc.yml

kubectl get ingress -n monitoring

kubectl get svc -n ingress-nginx