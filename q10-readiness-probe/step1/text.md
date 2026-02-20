# Task

Deployment `api-deploy` listens on port `8080` but has no probes.

## Add a readiness probe:

| Field | Value |
|-------|-------|
| Type | HTTP GET |
| Path | `/ready` |
| Port | `8080` |
| initialDelaySeconds | `5` |
| periodSeconds | `10` |

📖 [Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)

---

<details>
<summary>💡 Hint</summary>

```bash
kubectl edit deploy api-deploy
# Add readinessProbe under containers[0]
```

</details>

<details>
<summary>📝 Solution</summary>

```bash
kubectl edit deploy api-deploy
```

Add under `containers[0]`:
```yaml
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10
```

Verify:
```bash
kubectl rollout status deploy api-deploy
kubectl describe deploy api-deploy | grep -A5 Readiness
```

</details>
