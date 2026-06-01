#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s

kubectl create namespace web-ns --dry-run=client -o yaml | kubectl apply -f -

kubectl create deployment web-app \
  --image=nginx:alpine \
  --replicas=2 \
  -n web-ns \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl wait deployment web-app -n web-ns --for=condition=Available --timeout=60s

touch /tmp/.lab-setup-done
