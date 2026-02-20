# Solution

```bash
# Scale existing
kubectl scale deploy web-app --replicas=8

# Create canary
kubectl apply -f - <<'YAML'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app-canary
spec:
  replicas: 2
  selector:
    matchLabels:
      app: webapp
      version: v2
  template:
    metadata:
      labels:
        app: webapp
        version: v2
    spec:
      containers:
        - name: web
          image: nginx:latest
          ports:
            - containerPort: 80
YAML

# Verify both are in service endpoints
kubectl get endpoints web-service
```

**Key**: Service selects `app=webapp` — both deployments share this label.
