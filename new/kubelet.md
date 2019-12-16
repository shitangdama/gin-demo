cd /etc/systemd/system/kubelet.service.d/

cat 10-kubeadm.conf

Environment="KUBELET_EXTRA_ARGS=--read-only-port=10255"

sudo systemctl daemon-reload

sudo systemctl restart kubelet

参数
https://www.jianshu.com/p/36ad3028a710