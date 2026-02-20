#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
kubectl apply -f - <<'M'
apiVersion: apps/v1
kind: Deployment
metadata: { name: api-np-server, namespace: default, labels: { app: api } }
spec:
  replicas: 2
  selector: { matchLabels: { app: api } }
  template:
    metadata: { labels: { app: api } }
    spec:
      containers: [{ name: api, image: "nginx:latest", ports: [{ containerPort: 9090 }] }]
M
kubectl rollout status deploy/api-np-server --timeout=120s 2>/dev/null || true
touch /tmp/.lab-setup-done
