#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
kubectl apply -f - <<'M'
apiVersion: apps/v1
kind: Deployment
metadata: { name: app-v1, namespace: default }
spec:
  replicas: 3
  selector: { matchLabels: { app: app-v1 } }
  template:
    metadata: { labels: { app: app-v1 } }
    spec:
      containers: [{ name: web, image: "nginx:1.20", ports: [{ containerPort: 80 }] }]
M
kubectl rollout status deploy/app-v1 --timeout=120s 2>/dev/null || true
touch /tmp/.lab-setup-done
