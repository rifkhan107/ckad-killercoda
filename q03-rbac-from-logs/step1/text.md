# Task

In namespace `audit`, Pod `log-collector` is failing. Check logs:

```bash
kubectl logs -n audit log-collector
```

The logs show: `cannot list pods in namespace "audit"`

## Your Task

1. Create ServiceAccount `log-sa` in namespace `audit`
2. Create Role `log-role` granting `get`, `list`, `watch` on `pods`
3. Create RoleBinding `log-rb` binding `log-role` to `log-sa`
4. Update Pod `log-collector` to use `log-sa`

⚠️ Pod `serviceAccountName` is immutable — delete and recreate.

📖 [RBAC Docs](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

---

<details>
<summary>💡 Hint</summary>

```bash
kubectl create sa log-sa -n audit
kubectl create role log-role -n audit --verb=get,list,watch --resource=pods
kubectl create rolebinding log-rb -n audit --role=log-role --serviceaccount=audit:log-sa
```

</details>

<details>
<summary>📝 Solution</summary>

```bash
# Create RBAC resources
kubectl create sa log-sa -n audit
kubectl create role log-role -n audit --verb=get,list,watch --resource=pods
kubectl create rolebinding log-rb -n audit --role=log-role --serviceaccount=audit:log-sa

# Export, edit, and recreate the Pod
kubectl get pod log-collector -n audit -o yaml > /tmp/log-collector.yaml
```

Edit `/tmp/log-collector.yaml`:
- Change `serviceAccountName: default` → `serviceAccountName: log-sa`
- Remove `resourceVersion`, `uid`, `creationTimestamp`, `status` sections

```bash
kubectl delete pod log-collector -n audit
kubectl apply -f /tmp/log-collector.yaml

# Verify - should list pods without errors
kubectl logs -n audit log-collector
```

</details>
