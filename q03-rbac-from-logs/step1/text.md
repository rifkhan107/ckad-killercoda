# Task

In namespace `audit`, Pod `log-collector` is failing. Check logs:

```bash
kubectl logs -n audit log-collector
```

The logs show: `cannot list pods in namespace "audit"`

**Your Task:**

1. Create ServiceAccount `log-sa` in namespace `audit`
2. Create Role `log-role` granting `get`, `list`, `watch` on `pods`
3. Create RoleBinding `log-rb` binding `log-role` to `log-sa`
4. Update Pod `log-collector` to use `log-sa`

⚠️ Pod `serviceAccountName` is immutable — delete and recreate the Pod.

📖 [RBAC Docs](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
