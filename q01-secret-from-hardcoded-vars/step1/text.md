# Task

Deployment `api-server` in `default` has hard-coded env vars:

```
DB_USER=admin
DB_PASS=Secret123!
```

**Your Task:**

1. Create a Secret named `db-credentials` containing these credentials
2. Update Deployment `api-server` to use `valueFrom.secretKeyRef`
3. Do NOT change the Deployment name or namespace

📖 [Secrets Docs](https://kubernetes.io/docs/concepts/configuration/secret/)

> Click **Check** to verify, or **Next** for the solution.
