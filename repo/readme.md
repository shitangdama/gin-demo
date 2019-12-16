helm install stable/jaeger-operator --set nodeSelector.kubernetes.io/hostname=node1 --name-template jaeger

helm install --dry-run --debug . --name-template postgres

helm show values postgres

tar  zxvf

$ helm install --name kibana --namespace logging -f kibana-values.yaml mydlq/kibana

4fG9pbl25K

kubectl run postgres-postgresql-client --rm --tty -i --restart='Never' --namespace default --image docker.io/bitnami/postgresql:11.6.0-debian-9-r0 --env="PGPASSWORD=$POSTGRES_PASSWORD" --command -- psql --host postgres-postgresql -U shitangdama -d viki -p 5432

  * Within your cluster, at the following DNS name at port 9200:

    es-elasticsearch-client.default.svc

  * From outside the cluster, run these commands in the same shell:

    export POD_NAME=$(kubectl get pods --namespace default -l "app=elasticsearch,component=client,release=es" -o jsonpath="{.items[0].metadata.name}")
    echo "Visit http://127.0.0.1:9200 to use Elasticsearch"
    kubectl port-forward --namespace default $POD_NAME 9200:9200


curl -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6Im9fZVQ2VnpjMG1oUEw3VnNsdDFqQ0l6OVdYOU9qSlpTeV9scHNDTzFQRzAifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi10b2tlbi04bDVteiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJhZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjJjMjBkZjI5LTNkYTUtNDk0Mi05NzlmLTliYWI1YmFjYTMzZSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTphZG1pbiJ9.iuEoFxa3CZMwMHyI3HitJWlsq32ri1xlfNOlHJiqL8UDaNM5_X2gR0ESo1TioqD4X75W6jrXYXC4B-DMccp7wo2H3oyF2nRcHGltoTv59aGlTcieHYm7nKDrOq1iJl-PobAIFw6NeXJzpJtCZAqWpc1N9HIf0jF8cY5GTAhjFj-tsTli_h5U54rrEpV0dG83_CoPZ8XwOr02QD5B5fv5VKKPOxTs-BW3KjaDYI1Lv3R7S3Mu1i5Bk8l4FMLM0EAoYXag1wIW0qU8ERjm19n6QYc-GPS1xCMXMxOaeZmE7fVNjGtvVL0rY_nyhgW1LS8Z3QIJvC-m5AdITZeFqy-Huw" https://192.168.123.142:6443/metric  --insecure

curl -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6Im9fZVQ2VnpjMG1oUEw3VnNsdDFqQ0l6OVdYOU9qSlpTeV9scHNDTzFQRzAifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJtb25pdG9yaW5nIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6InByb21ldGhldXMtb3BlcmF0b3ItdG9rZW4tbXZsbGgiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoicHJvbWV0aGV1cy1vcGVyYXRvciIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImE1MzU0NzYwLWI0ZDctNDRlYS1hYjk1LTU5NmIxMzk2NWMxMiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDptb25pdG9yaW5nOnByb21ldGhldXMtb3BlcmF0b3IifQ.SfxE_Gd_74rTA_jx18FuOHEYFf7Sqe6YUc3di9miX0reRvgScd4YlQ7DglmDtdwC2Qo66U6Sa-tCYO0kFEF6y9TEf5xndy3ax45NYGP6Qti4pCeDT8Rl9N2WMl6LkM6siiS_V3r0C73t7DKp-dFnBn-ZD6wnu6hWzgwH5RJ2DUM4LFOl3PoaTLg32OU_vvLzkoXAUu7PrJ0STDd6tCzAy8lphqIJ04iwrV1LHJkpacexZTW7I8vbO3TbExi8Lf1f_HpuV6PdElOqoTcDJZxbZQGSwuUF7v9KTN0iouKWaQkJgVlxr3JPQqfPR75CT" https://192.168.123.142:6443/metric  --insecure

默认会从kubelet的基于HTTP的10255端口获取指标数据，但出于安全通信目的，kubeadm在初始化集群时会关掉10255端口，导致无法正常获取数据

kubectl describe secrets $(kubectl get secrets -n kube-system |grep admin |cut -f1 -d ' ') -n kube-system |grep -E '^token' |cut -f2 -d':'|tr -d '\t'|tr -d ' '

kubectl describe secrets $(kubectl get secrets -n monitoring |grep prometheus-k8s |cut -f1 -d ' ') -n monitoring |grep -E '^token' |cut -f2 -d':'|tr -d '\t'|tr -d ' '

TOKEN=$(kubectl describe secrets $(kubectl get secrets -n kube-system |grep admin |cut -f1 -d ' ') -n kube-system |grep -E '^token' |cut -f2 -d':'|tr -d '\t'|tr -d ' ')

APISERVER=$(kubectl config view |grep server|cut -f 2- -d ":" | tr -d " ")

 kubectl config view |grep server|cut -f 2- -d ":" | tr -d " "


curl -H "Authorization: Bearer $TOKEN" $APISERVER/api  --insecure