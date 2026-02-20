# Q3 – Create ServiceAccount, Role, and RoleBinding from Logs Error

In namespace `audit`, Pod `log-collector` exists but is failing with authorization errors.

## Investigation

Check the Pod logs to identify what permissions are needed:

```bash
kubectl logs -n audit log-collector
```

## Your Task

1. Create a ServiceAccount named `log-sa` in namespace `audit`
2. Create a Role `log-role` that grants `get`, `list`, and `watch` on resource `pods`
3. Create a RoleBinding `log-rb` binding `log-role` to `log-sa`
4. Update Pod `log-collector` to use ServiceAccount `log-sa`

> ⚠️ **Note**: Pod `serviceAccountName` is immutable. You'll need to delete and recreate the Pod.

## Hints

<details>
<summary>💡 Hint</summary>

```bash
kubectl get pod log-collector -n audit -o yaml > /tmp/log-collector.yaml
# Edit serviceAccountName, then delete & recreate
```
</details>

## Docs

- [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
