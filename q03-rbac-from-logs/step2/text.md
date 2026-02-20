# Solution

```bash
# ServiceAccount
kubectl create sa log-sa -n audit

# Role
kubectl create role log-role -n audit \
  --verb=get,list,watch --resource=pods

# RoleBinding
kubectl create rolebinding log-rb -n audit \
  --role=log-role --serviceaccount=audit:log-sa

# Recreate Pod with correct SA
kubectl get pod log-collector -n audit -o yaml > /tmp/log-collector.yaml
```

Edit `/tmp/log-collector.yaml` — change `serviceAccountName: default` to `serviceAccountName: log-sa`.
Remove `resourceVersion`, `uid`, `creationTimestamp`, `status` fields.

```bash
kubectl delete pod log-collector -n audit
kubectl apply -f /tmp/log-collector.yaml
```

**Verify:**
```bash
kubectl logs -n audit log-collector
# Should list pods without errors
```
