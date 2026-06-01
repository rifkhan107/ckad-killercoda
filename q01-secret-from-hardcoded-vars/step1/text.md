# Task

Deployment `api-server` in namespace `default` has **three hardcoded database credentials** in its container environment variables.

## Your Task

1. Inspect the deployment to find the current env var names and their values
2. Create a Secret named `db-credentials` in namespace `default` with these keys:
   - `username`
   - `password`
   - `database`
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

The secret keys are lowercase (`username`, `password`, `database`) — but the env var **names** in the deployment stay as they are (`DB_USER`, `DB_PASS`, `DB_NAME`). These are different things.

```bash
kubectl create secret generic db-credentials \
  --from-literal=username=<value> \
  --from-literal=password=<value> \
  --from-literal=database=<value>
```

</details>

<details>
<summary>📝 Solution</summary>

### Step 1 – Discover the hardcoded values
```bash
kubectl describe deployment api-server
# Look under "Environment:" — note the values next to DB_USER, DB_PASS, DB_NAME
```

### Step 2 – Create the Secret (lowercase keys)
```bash
kubectl create secret generic db-credentials \
  --from-literal=username=admin \
  --from-literal=password=Secret123! \
  --from-literal=database=mydb
```

### Step 3 – Update the Deployment
```bash
kubectl edit deploy api-server
```

Replace the `env:` block with — note `name:` stays uppercase, `key:` is lowercase:
```yaml
env:
  - name: DB_USER
    valueFrom:
      secretKeyRef:
        name: db-credentials
        key: username
  - name: DB_PASS
    valueFrom:
      secretKeyRef:
        name: db-credentials
        key: password
  - name: DB_NAME
    valueFrom:
      secretKeyRef:
        name: db-credentials
        key: database
```

### Verify
```bash
kubectl rollout status deploy api-server
kubectl exec deploy/api-server -- env | grep DB_
```

</details>
