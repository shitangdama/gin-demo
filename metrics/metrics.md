#监控

安装 metrics server

kubectl create -f ./metrics/

kubectl -n kube-system get pods -l k8s-app=metrics-server

kubectl describe pod metrics-server-6764b987d-vt95l -n kube-system

等一会

# 测试获取数据
# 由于采集数据间隔为1分钟
# 等待数分钟后查看数据
NODE=$(kubectl get nodes | grep 'Ready' | head -1 | awk '{print $1}')
METRIC_SERVER_POD=$(kubectl get pods -n kube-system | grep 'metrics-server' | awk '{print $1}')
kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes
kubectl get --raw /apis/metrics.k8s.io/v1beta1/pods
kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes/$NODE

kubectl top node $NODE
kubectl top pod $METRIC_SERVER_POD -n kube-system