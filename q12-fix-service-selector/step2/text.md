# Solution

```bash
kubectl edit svc web-svc
```

Change `app: wrongapp` to `app: webapp`:
```yaml
spec:
  selector:
    app: webapp
```

Verify:
```bash
kubectl get endpoints web-svc
# Should now show pod IPs
```
