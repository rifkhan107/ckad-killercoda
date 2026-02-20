#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
kubectl create ns prod
kubectl apply -f - <<'M'
apiVersion: v1
kind: ResourceQuota
metadata: { name: prod-quota, namespace: prod }
spec:
  hard:
    limits.cpu: "2"
    limits.memory: 4Gi
    requests.cpu: "1"
    requests.memory: 2Gi
    pods: "5"
M
touch /tmp/.lab-setup-done
