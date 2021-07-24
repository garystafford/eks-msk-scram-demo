# Helm Chart: kafka-client-msk

## Deploy Helm Chart

```shell
# perform dry run
helm install kafka-client-msk ./kafka-client-msk \
  --namespace $NAMESPACE --debug --dry-run

# apply chart resources
helm install kafka-client-msk ./kafka-client-msk \
  --namespace $NAMESPACE --create-namespace

# optional: update
helm upgrade kafka-client-msk ./kafka-client-msk --namespace $NAMESPACE

kubectl get pods -n kafka
kubectl describe pod -n kafka -l app=kafka-client-msk
```
