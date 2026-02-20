# Q7 – Fix NetworkPolicy by Updating Pod Labels

In namespace `network-demo`, three Pods exist with **incorrect** labels:

| Pod | Current Label | Needed By NetworkPolicy |
|-----|---------------|------------------------|
| `frontend` | `role=wrong-frontend` | `role=frontend` |
| `backend` | `role=wrong-backend` | `role=backend` |
| `database` | `role=wrong-db` | `role=db` |

Three NetworkPolicies exist:

- `deny-all` — default deny all traffic
- `allow-frontend-to-backend` — allows `role=frontend` → `role=backend`
- `allow-backend-to-db` — allows `role=backend` → `role=db`

## Your Task

Update the **Pod labels** (do NOT modify NetworkPolicies) to enable:

```
frontend → backend → database
```

> ⏱️ **Time Saver**: Use `kubectl label --overwrite` instead of editing YAML.

## Docs

- [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policy/)
