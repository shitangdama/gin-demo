比较挂载和localpv


先试用初始化容器
测试本地挂载
然后在使用localpv

暴露端口

kubectl port-forward xxxx 10080:80

StorageClass 和 pvc区别


1. emptyDir
生存周期和pod一样

2. hostPath Volume 

