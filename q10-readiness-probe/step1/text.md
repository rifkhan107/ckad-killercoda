# Task

Deployment `api-deploy` listens on port `8080` but has no probes.

**Add a readiness probe:**

| Field | Value |
|-------|-------|
| Type | HTTP GET |
| Path | `/ready` |
| Port | `8080` |
| initialDelaySeconds | `5` |
| periodSeconds | `10` |

```bash
kubectl edit deploy api-deploy
```

📖 [Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
