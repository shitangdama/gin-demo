##pod测试
#关于pod自动扩容缩容

kubectl apply -f deployment/nginx-deployment.yaml --record
kubectl rollout status deployment/nginx
kubectl edit deployment/nginx

kubectl rollout undo deployment/nginx

kubectl set image deployment/nginx nginx=nginx:1.17

kubectl rollout history deployment/nginx

kubectl rollout history deployment/nginx --revision=2

kubectl rollout undo deployment/nginx --to-revision=2


kubectl rollout pause deployment/nginx
kubectl set image deployment/nginx nginx=nginx:1.17.1

kubectl rollout resume deployment/nginx

statefulset

service

访问方式
- 1 vip cluster ip
- 2 dns my-svc.my-namespace.svc.cluster.local制定为一个pod
    - 1 normal service my-svc.my-namespace.svc.cluster.local解析道cluster ip上去
    - 2 headless service my-svc.my-namespace.svc.cluster.local直接就是pod的ip地址，不需要有cluster ip

headless sevice 没有vip做头，设置cluster ip 为none 不会被分派vip
pod-name.svc-name.namespace.svc.cluster.local

