# Q10 – Add Readiness Probe to Deployment

In namespace `default`, Deployment `api-deploy` exists with a container listening on port `8080`.

## Your Task

Add a **readiness probe** to the Deployment:

| Field | Value |
|-------|-------|
| Type | HTTP GET |
| Path | `/ready` |
| Port | `8080` |
| initialDelaySeconds | `5` |
| periodSeconds | `10` |

Ensure the Deployment rolls out successfully.

## Hints

<details>
<summary>💡 Hint</summary>

```bash
kubectl edit deploy api-deploy
# Add under containers[0]:
#   readinessProbe:
#     httpGet:
#       path: /ready
#       port: 8080
#     initialDelaySeconds: 5
#     periodSeconds: 10
```
</details>

## Docs

- [Configure Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
