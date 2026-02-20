#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
kubectl create ns audit
kubectl apply -f - <<'M'
apiVersion: v1
kind: Pod
metadata:
  name: log-collector
  namespace: audit
spec:
  serviceAccountName: default
  containers:
    - name: collector
      image: bitnami/kubectl:latest
      command: ["sh", "-c", "while true; do kubectl get pods -n audit 2>&1 || true; sleep 10; done"]
M
touch /tmp/.lab-setup-done
