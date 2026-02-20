# Q1 – Create Secret from Hardcoded Variables

In namespace `default`, Deployment `api-server` exists with hard-coded environment variables:

```
DB_USER=admin
DB_PASS=Secret123!
```

## Your Task

1. Create a Secret named `db-credentials` in namespace `default` containing these credentials
2. Update Deployment `api-server` to use the Secret via `valueFrom.secretKeyRef`
3. Do **not** change the Deployment name or namespace

## Hints

<details>
<summary>💡 Hint 1</summary>

```bash
kubectl create secret generic db-credentials \
  --from-literal=DB_USER=admin \
  --from-literal=DB_PASS=Secret123!
```
</details>

<details>
<summary>💡 Hint 2</summary>

Use `kubectl edit deploy api-server` and replace each `value:` with a `valueFrom.secretKeyRef` block.
</details>

## Docs

- [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
