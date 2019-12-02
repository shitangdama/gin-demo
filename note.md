1. Secret类型
Secret有三种类型：

Opaque：使用base64编码存储信息，可以通过base64 --decode解码获得原始数据，因此安全性弱。
kubernetes.io/dockerconfigjson：用于存储docker registry的认证信息。
kubernetes.io/service-account-token：用于被 serviceaccount 引用。serviceaccout 创建时 Kubernetes 会默认创建对应的 secret。Pod 如果使用了 serviceaccount，对应的 secret 会自动挂载到 Pod 的 /run/secrets/kubernetes.io/serviceaccount 目录中。
https://www.jianshu.com/p/1c54a8a33217
