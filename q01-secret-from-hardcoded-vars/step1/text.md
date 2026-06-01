# Task

Deployment `api-server` in namespace `default` has **three hardcoded database credentials** in its container environment variables.

## Your Task

1. Inspect the deployment to find the current env var names and values
2. Create a Secret named `db-credentials` in namespace `default` containing all three credentials
3. Update Deployment `api-server` to source all three env vars from the Secret using `valueFrom.secretKeyRef`

```bash
# Discover the hardcoded values
kubectl describe deployment api-server
```

📖 [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)

---

<details>
<summary>💡 Hint</summary>

```bash
# Find the values
kubectl get deployment api-server -o yaml | grep -A3 "env:"
```

Once you have the values, create the secret:
```bash
kubectl create secret generic db-credentials \
  --from-literal=DB_USER=<value> \
  --from-literal=DB_PASS=<value> \
  --from-literal=DB_NAME=<value>
```

Then edit the deployment to replace each `value:` with `valueFrom.secretKeyRef`.

</details>

<details>
<summary>📝 Solution</summary>

### Step 1 – Discover the hardcoded values
```bash
kubectl describe deployment api-server
# Look under "Environment:" in the container section
```

### Step 2 – Create the Secret
```bash
kubectl create secret generic db-credentials \
  --from-literal=DB_USER=admin \
  --from-literal=DB_PASS=Secret123! \
  --from-literal=DB_NAME=mydb
```

### Step 3 – Update the Deployment
```bash
kubectl edit deploy api-server
```

Replace the `env:` block with:
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
  - name: DB_NAME
    valueFrom:
      secretKeyRef:
        name: db-credentials
        key: DB_NAME
```

### Verify
```bash
kubectl rollout status deploy api-server
kubectl exec deploy/api-server -- env | grep DB_
```

</details>
