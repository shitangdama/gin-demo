nameOverride: "deployment-test"
fullnameOverride: "deployment-test"
instanceOverride: "deployment-test"


NOTES:
PostgreSQL can be accessed via port 5432 on the following DNS name from within your cluster:
master-postgres.default.svc.cluster.local

To get your user password run:

    PGPASSWORD=$(kubectl get secret --namespace default master-postgres -o jsonpath="{.data.postgres-password}" | base64 --decode; echo)

To connect to your database run the following command (using the env variable from above):

   kubectl run --namespace default master-postgres-client --restart=Never --rm --tty -i --image postgres \
   --env "PGPASSWORD=$PGPASSWORD" \
   --command -- psql -U postgres \
   -h master-postgres saki



To connect to your database directly from outside the K8s cluster:
     PGHOST=127.0.0.1
     PGPORT=5432

     # Execute the following commands to route the connection:
     export POD_NAME=$(kubectl get pods --namespace default -l "app=master-postgres" -o jsonpath="{.items[0].metadata.name}")
     kubectl port-forward --namespace default $POD_NAME 5432:5432

     master-postgres.default.svc.cluster.local