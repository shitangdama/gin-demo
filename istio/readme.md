Envoy：Lyft 开源的高性能代理，用于调解服务网格中所有服务的入站和出站流量。它支持动态服务发现、负载均衡、TLS 终止、HTTP/2 和 gPRC 代理、熔断、健康检查、故障注入和性能测量等丰富的功能。Envoy 以 sidecar 的方式部署在相关的服务的 Pod 中，从而无需重新构建或重写代码。
Mixer：负责访问控制、执行策略并从 Envoy 代理中收集遥测数据。Mixer 支持灵活的插件模型，方便扩展（支持 GCP、AWS、Prometheus、Heapster 等多种后端）。
Pilot：动态管理 Envoy 实例的生命周期，提供服务发现、智能路由和弹性流量管理（如超时、重试）等功能。它将流量管理策略转化为 Envoy 数据平面配置，并传播到 sidecar 中。
Pilot 为 Envoy sidecar 提供服务发现功能，为智能路由（例如 A/B 测试、金丝雀部署等）和弹性（超时、重试、熔断器等）提供流量管理功能。它将控制流量行为的高级路由规则转换为特定于 Envoy 的配置，并在运行时将它们传播到 sidecar。Pilot 将服务发现机制抽象为符合 Envoy 数据平面 API 的标准格式，以便支持在多种环境下运行并保持流量管理的相同操作接口。
Citadel 通过内置身份和凭证管理提供服务间和最终用户的身份认证。支持基于角色的访问控制、基于服务标识的策略执行等。


https://cloud.tencent.com/developer/article/1556214


Hystrix 原理与实战




sudo  chmod +x /usr/local/bin/istioctl

istioctl manifest apply --set profile=demo --set cni.enabled=true --set cni.components.cni.namespace=kube-system --set values.gateways.istio-ingressgateway.type=ClusterIP



kubectl label namespace default istio-injection=enabled

istioctl manifest generate --set profile=demo | kubectl delete -f -

curl -v http://192.168.123.142 -H 'host: p8s.shitangdama.cn'


kubectl apply -f nginx-istio-test.yaml