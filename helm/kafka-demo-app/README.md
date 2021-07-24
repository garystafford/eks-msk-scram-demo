# Helm Chart: kafka-demo-app

## Deploy Helm Chart

```shell
# perform dry run
helm install kafka-demo-app ./kafka-demo-app \
    --namespace $NAMESPACE --debug --dry-run

# apply chart resources
helm install kafka-demo-app ./kafka-demo-app \
    --namespace $NAMESPACE --create-namespace

# optional: update
helm upgrade kafka-demo-app ./kafka-demo-app --namespace $NAMESPACE

kubectl get pods -n kafka
kubectl describe pod -n kafka -l app=kafka-demo-service-a
```
