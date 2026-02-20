# Solution

## Step 1 – Create the Secret
```bash
kubectl create secret generic db-credentials \
  --from-literal=DB_USER=admin \
  --from-literal=DB_PASS=Secret123!
```

## Step 2 – Update Deployment
```bash
kubectl edit deploy api-server
```

Replace hardcoded `value:` fields with:
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

## Verify
```bash
kubectl rollout status deploy api-server
```
