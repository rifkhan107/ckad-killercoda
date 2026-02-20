# Task

In namespace `monitoring`, Pod `metrics-pod` uses `wrong-sa` and has auth errors.

Existing resources:
- **ServiceAccounts**: `monitor-sa`, `wrong-sa`, `admin-sa`
- **Roles**: `metrics-reader`, `full-access`, `view-only`
- **RoleBindings**: `monitor-binding`, `admin-binding`

## Your Task

1. Investigate which SA has correct permissions for reading pods
2. Update `metrics-pod` to use the correct ServiceAccount

```bash
kubectl get rolebindings -n monitoring -o wide
kubectl describe role metrics-reader -n monitoring
```

📖 [ServiceAccounts](https://kubernetes.io/docs/concepts/security/service-accounts/)

---

<details>
<summary>💡 Hint</summary>

Check `monitor-binding` — it binds `monitor-sa` to `metrics-reader` role which has pod read permissions.

</details>

<details>
<summary>📝 Solution</summary>

```bash
# Investigate
kubectl get rolebindings -n monitoring -o wide
# monitor-binding → metrics-reader → monitor-sa ✓
# wrong-sa has NO binding → that's why it fails

# Fix - export, edit, recreate
kubectl get pod metrics-pod -n monitoring -o yaml > /tmp/metrics-pod.yaml
```

Edit `/tmp/metrics-pod.yaml` — change `serviceAccountName: wrong-sa` → `serviceAccountName: monitor-sa`

```bash
kubectl delete pod metrics-pod -n monitoring
kubectl apply -f /tmp/metrics-pod.yaml

# Verify
kubectl logs metrics-pod -n monitoring
```

</details>
