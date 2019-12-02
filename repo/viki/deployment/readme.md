kubectl create secret docker-registry registrykey --docker-server=registry.shitangdama.cn --docker-username=shitangdama --docker-password=kbr199sd5shi --docker-email=kbr1990117@gmail.com

curl -kivL -H 'Host: viki-api.shitangdama.cn' 'https://localhost'

例如
下拉镜像：quay.io/coreos/flannel:v0.10.0-s390x
如果拉取较慢，可以改为：quay-mirror.qiniu.com/coreos/flannel:v0.10.0-s390x

下拉镜像：gcr.io/google_containers/kube-proxy
可以改为： registry.aliyuncs.com/google_containers/kube-proxy
————————————————
版权声明：本文为CSDN博主「Weshzhu」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/zsd498537806/article/details/85157560