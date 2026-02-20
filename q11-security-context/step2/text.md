# Solution

```bash
kubectl edit deploy secure-app
```

```yaml
spec:
  template:
    spec:
      securityContext:          # Pod-level
        runAsUser: 1000
      containers:
        - name: app
          securityContext:      # Container-level
            capabilities:
              add: ["NET_ADMIN"]
```
