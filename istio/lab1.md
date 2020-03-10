https://github.com/jonielsen/istioworkshop/tree/d32e22a7d658d26116149854709c51fd264c3d64/05-Istio-Lab1
https://cloud.tencent.com/developer/article/1556214




istioctl manifest apply -f cni.yaml

删除所有的 istio-cni-node Pod：
kubectl -n kube-system delete pod -l k8s-app=istio-cni-node

kubectl label namespace default istio-injection=enabled
kubectl label namespace default istio-injection-


 istioctl kube-inject -f my-websites.yaml -o my-websites-with-proxy.yaml


kubectl apply -f ingress/web_ingress.yaml