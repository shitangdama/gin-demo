#部署mongo和mongo-express

一个service
一个deployment

apiVersion api版本，我们可以通过kubectl api-versions查看个api组的版本，不同组API版本是不一样的，Pod属于核心API，版本为V1；
kind 编排对象，此处是pod，以后还会学习Deployment、StatefulSet、DaemonSet、Service、Ingress等编排对象；
metadata 元数据，用来定义编排对象的名字（name），所在命名空间（namespace）、标签（labels）、注解（annotations）等，在Kubernetes世界里，一个API对象通过标签（label selector）来选择另一个API对象，所以为对象定义标签是很重要的；metadata中的注解（annotations）是给Kubernetes看的，比如告诉Kubernetes开启某些功能；
spec 描述，用来描述这个API对象的期望状态，比如如何调度、如何配置网络、如何配置存储、如何配置安全上下文、如何启动容器等等；
status 状态，这个字段是只读的，用来展示这个API对象的实际状态，status有包括conditions详细状态和containerStatuses，后面会详细介绍。


#关于Label

