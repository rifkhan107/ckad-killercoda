#!/bin/bash

SA=$(kubectl get pod metrics-pod -n monitoring -o jsonpath='{.spec.serviceAccountName}' 2>/dev/null)
[ "$SA" = "monitor-sa" ] || {
  echo "❌ Pod metrics-pod is using ServiceAccount '$SA', expected 'monitor-sa'"
  exit 1
}

kubectl get pod metrics-pod -n monitoring &>/dev/null || {
  echo "❌ Pod metrics-pod not found in monitoring namespace"
  exit 1
}

echo "✅ Q4 Passed: Pod metrics-pod now uses correct ServiceAccount 'monitor-sa'"
