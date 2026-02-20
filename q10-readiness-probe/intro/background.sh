#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
kubectl apply -f - <<'M'
apiVersion: apps/v1
kind: Deployment
metadata: { name: api-deploy, namespace: default }
spec:
  replicas: 2
  selector: { matchLabels: { app: api-deploy } }
  template:
    metadata: { labels: { app: api-deploy } }
    spec:
      containers: [{ name: api, image: "nginx:latest", ports: [{ containerPort: 8080 }] }]
M
kubectl rollout status deploy/api-deploy --timeout=120s 2>/dev/null || true
touch /tmp/.lab-setup-done
