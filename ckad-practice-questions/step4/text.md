# Q4 – Fix Broken Pod with Correct ServiceAccount

In namespace `monitoring`, Pod `metrics-pod` is using ServiceAccount `wrong-sa` and receiving authorization errors.

Multiple ServiceAccounts, Roles, and RoleBindings already exist:

| ServiceAccounts | Roles | RoleBindings |
|----------------|-------|--------------|
| `monitor-sa` | `metrics-reader` | `monitor-binding` |
| `wrong-sa` | `full-access` | `admin-binding` |
| `admin-sa` | `view-only` | |

## Your Task

1. Investigate which ServiceAccount/Role/RoleBinding combination has the correct permissions for reading pod metrics
2. Update Pod `metrics-pod` to use the **correct** ServiceAccount
3. Verify the Pod stops showing authorization errors

## Hints

<details>
<summary>💡 Hint</summary>

Check existing RoleBindings to see which ServiceAccount is bound to which Role:

```bash
kubectl get rolebindings -n monitoring -o wide
kubectl describe role metrics-reader -n monitoring
```
</details>

## Docs

- [ServiceAccounts](https://kubernetes.io/docs/concepts/security/service-accounts/)
