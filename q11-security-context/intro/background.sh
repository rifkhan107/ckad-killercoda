#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
kubectl apply -f - <<'M'
apiVersion: apps/v1
kind: Deployment
metadata: { name: secure-app, namespace: default }
spec:
  replicas: 1
  selector: { matchLabels: { app: secure-app } }
  template:
    metadata: { labels: { app: secure-app } }
    spec:
      containers: [{ name: app, image: "nginx:latest", ports: [{ containerPort: 80 }] }]
M
kubectl rollout status deploy/secure-app --timeout=120s 2>/dev/null || true
touch /tmp/.lab-setup-done
