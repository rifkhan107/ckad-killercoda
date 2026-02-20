# Task

Existing resources:
- Deployment `web-app`: 5 replicas, labels `app=webapp, version=v1`
- Service `web-service`: selector `app=webapp`

## Your Task

1. Scale `web-app` to **8** replicas
2. Create Deployment `web-app-canary` with **2** replicas, labels `app=webapp, version=v2`
3. Both must be selected by `web-service`

📖 [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

---

<details>
<summary>💡 Hint</summary>

Service selects `app=webapp` — both deployments need this label on pod template. Use `version` to differentiate in `selector.matchLabels`.

</details>

<details>
<summary>📝 Solution</summary>

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

# Verify both in service endpoints
kubectl get endpoints web-service
```

</details>
