# Task

Deployment `api-server` in `default` has hard-coded env vars:

```
DB_USER=admin
DB_PASS=Secret123!
```

## Your Task

1. Create a Secret named `db-credentials` containing these credentials
2. Update Deployment `api-server` to use `valueFrom.secretKeyRef`
3. Do NOT change the Deployment name or namespace

📖 [Secrets Docs](https://kubernetes.io/docs/concepts/configuration/secret/)

---

<details>
<summary>💡 Hint</summary>

```bash
kubectl create secret generic db-credentials \
  --from-literal=DB_USER=admin \
  --from-literal=DB_PASS=Secret123!
```

Then `kubectl edit deploy api-server` and replace `value:` with `valueFrom.secretKeyRef`.

</details>

<details>
<summary>📝 Solution</summary>

### Step 1 – Create the Secret
```bash
kubectl create secret generic db-credentials \
  --from-literal=DB_USER=admin \
  --from-literal=DB_PASS=Secret123!
```

### Step 2 – Update Deployment
```bash
kubectl edit deploy api-server
```

Replace the hardcoded env section with:
```yaml
env:
  - name: DB_USER
    valueFrom:
      secretKeyRef:
        name: db-credentials
        key: DB_USER
  - name: DB_PASS
    valueFrom:
      secretKeyRef:
        name: db-credentials
        key: DB_PASS
```

### Verify
```bash
kubectl rollout status deploy api-server
```

</details>
