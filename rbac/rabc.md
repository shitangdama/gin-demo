authentication 认证

On GCE, Client Certificates, Password, Plain Tokens, and JWT Tokens are all enabled.

authorization  授权

注意kubeadm创建的k8s集群里面的认证key是有有效期的

关于kubectl 和 api
username uid




 k8s验证分为useraccount和serviceaccount。
关于service account 
用户是user account 程序是service account

用户应该是认证部分

rbac授权部分

user - The user string provided during authentication.
group - The list of group names to which the authenticated user belongs.
extra - A map of arbitrary string keys to string values, provided by the authentication layer.
API - Indicates whether the request is for an API resource.
Request path - Path to miscellaneous non-resource endpoints like /api or /healthz.
API request verb - API verbs get, list, create, update, patch, watch, proxy, redirect, delete, and deletecollection are used for resource requests. To determine the request verb for a resource API endpoint, see Determine the request verb.
HTTP request verb - HTTP verbs get, post, put, and delete are used for non-resource requests.
Resource - The ID or name of the resource that is being accessed (for resource requests only) – For resource requests using get, update, patch, and delete verbs, you must provide the resource name.
Subresource - The subresource that is being accessed (for resource requests only).
Namespace - The namespace of the object that is being accessed (for namespaced resource requests only).
API group - The API group being accessed (for resource requests only). An empty string designates the core API group.

关于用户和角色的绑定

需要一个前端和后段存储用户关系和认证

rules中的参数说明：

　　  - apiGroup：支持的API组列表，例如：APIVersion: batch/v1、APIVersion: extensions:v1、apiVersion:apps/v1等

　　    resources：支持的资源对象列表，例如：pods、deployments、jobs等

　　    verbs：对资源对象的操作方法列表，例如：get、watch、list、delete、replace、patch等

- 集群角色(ClusterRole)

　　  集群角色除了具有和角色一致的命名空间内资源的管理能力，因其集群级别的范围，还可以用于以下特殊元素的授权。

　　  - 集群范围的资源，例如Node

　　    非资源型的路径，例如/healthz

　　    包含全部命名空间的资源，例如pods
https://jimmysong.io/kubernetes-handbook/concepts/rbac.html

写个前端

先要有用户的认证

然后创建不同的用户，组，角色


关于用户组设置


使用client-go链接集群

学习kubeconfig, 是什么