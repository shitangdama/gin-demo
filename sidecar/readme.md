1.api请求到达K8S API Server
2.请求要先经过认证

    kubectl调用需要kubeconfig
    直接调用K8S api需要证书+bearToken
    client-go调用也需要kubeconfig
3.执行一连串的admission controller，包括MutatingAdmissionWebhook和ValidatingAdmissionWebhook, 先串行执行MutatingAdmission的Webhook list
4.对请求对象的schema进行校验
5.并行执行ValidatingAdmission的Webhook list
6.最后写入etcd


Mutation

Mutation是英文“突变”的意思,从字面上可以知道在Mutation阶段可以对请求内容进行修改。

Validation

在Validation阶段不允许修改请求内容，但可以根据请求的内容判断是继续执行该请求还是拒绝该请求。