#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
kubectl apply -f - <<'M'
apiVersion: apps/v1
kind: Deployment
metadata: { name: web-app, namespace: default }
spec:
  replicas: 5
  selector: { matchLabels: { app: webapp, version: v1 } }
  template:
    metadata: { labels: { app: webapp, version: v1 } }
    spec:
      containers:
        - { name: web, image: "nginx:1.24", ports: [{ containerPort: 80 }] }
---
apiVersion: v1
kind: Service
metadata: { name: web-service, namespace: default }
spec:
  selector: { app: webapp }
  ports: [{ port: 80, targetPort: 80 }]
M
kubectl rollout status deploy/web-app --timeout=120s 2>/dev/null || true
touch /tmp/.lab-setup-done
