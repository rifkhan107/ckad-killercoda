# Task

In `network-demo`, Pods have wrong labels:

| Pod | Current Label | NetworkPolicy Expects |
|-----|--------------|----------------------|
| frontend | `role=wrong-frontend` | ? |
| backend | `role=wrong-backend` | ? |
| database | `role=wrong-db` | ? |

**Your Task:** Update Pod labels (do NOT modify NetworkPolicies) to enable:
```
frontend → backend → database
```

💡 Use `kubectl get netpol -n network-demo -o yaml` to see expected labels.

📖 [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policy/)
