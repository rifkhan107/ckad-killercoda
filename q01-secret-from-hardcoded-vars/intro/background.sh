#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
kubectl create namespace prod --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f - <<'M'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-server
  namespace: prod
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
          command: ["sh", "-c", "while true; do echo connecting to $DB_NAME as $DB_USER; sleep 30; done"]
          env:
            - name: DB_USER
              value: "admin"
            - name: DB_PASS
              value: "Secret123!"
            - name: DB_NAME
              value: "mydb"
M
kubectl rollout status deploy/api-server -n prod --timeout=120s 2>/dev/null || true
touch /tmp/.lab-setup-done
