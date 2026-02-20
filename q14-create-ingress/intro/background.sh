#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
kubectl apply -f - <<'M'
apiVersion: apps/v1
kind: Deployment
metadata: { name: web-deploy, namespace: default }
spec:
  replicas: 2
  selector: { matchLabels: { app: web } }
  template:
    metadata: { labels: { app: web } }
    spec:
      containers: [{ name: web, image: "nginx:latest", ports: [{ containerPort: 8080 }] }]
---
apiVersion: v1
kind: Service
metadata: { name: web-svc, namespace: default }
spec:
  selector: { app: web }
  ports: [{ port: 8080, targetPort: 8080 }]
M
kubectl rollout status deploy/web-deploy --timeout=120s 2>/dev/null || true
touch /tmp/.lab-setup-done
