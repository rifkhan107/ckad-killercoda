#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
kubectl apply -f - <<'M'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-server
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: api-server
  template:
    metadata:
      labels:
        app: api-server
    spec:
      containers:
        - name: api
          image: busybox:latest
          command: ["sh", "-c", "while true; do echo DB_USER=$DB_USER DB_PASS=$DB_PASS; sleep 30; done"]
          env:
            - name: DB_USER
              value: "admin"
            - name: DB_PASS
              value: "Secret123!"
M
kubectl rollout status deploy/api-server --timeout=120s 2>/dev/null || true
touch /tmp/.lab-setup-done
