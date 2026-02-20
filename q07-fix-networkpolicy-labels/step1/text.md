# Task

In `network-demo`, Pods have wrong labels. NetworkPolicies expect:

- `allow-frontend-to-backend`: `role=frontend` → `role=backend`
- `allow-backend-to-db`: `role=backend` → `role=db`

Current labels: `role=wrong-frontend`, `role=wrong-backend`, `role=wrong-db`

## Your Task

Update **Pod labels only** (do NOT modify NetworkPolicies) to enable:
```
frontend → backend → database
```

```bash
kubectl get netpol -n network-demo -o yaml
```

📖 [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policy/)

---

<details>
<summary>💡 Hint</summary>

Use `kubectl label --overwrite` for quick label changes without recreating pods.

</details>

<details>
<summary>📝 Solution</summary>

```bash
kubectl label pod frontend -n network-demo role=frontend --overwrite
kubectl label pod backend -n network-demo role=backend --overwrite
kubectl label pod database -n network-demo role=db --overwrite

# Verify
kubectl get pods -n network-demo --show-labels
```

</details>
