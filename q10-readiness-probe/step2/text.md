# Solution

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
