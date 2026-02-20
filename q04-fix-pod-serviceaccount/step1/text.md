# Task

In namespace `monitoring`, Pod `metrics-pod` uses `wrong-sa` and has auth errors.

Existing resources:
- **ServiceAccounts**: `monitor-sa`, `wrong-sa`, `admin-sa`
- **Roles**: `metrics-reader`, `full-access`, `view-only`
- **RoleBindings**: `monitor-binding`, `admin-binding`

**Your Task:**
1. Investigate which SA has correct permissions for reading pods
2. Update `metrics-pod` to use the correct ServiceAccount

```bash
kubectl get rolebindings -n monitoring -o wide
kubectl describe role metrics-reader -n monitoring
```

📖 [ServiceAccounts](https://kubernetes.io/docs/concepts/security/service-accounts/)
