#!/bin/bash
kubectl get pod metrics-pod -n monitoring &>/dev/null || { echo "❌ Pod not found"; exit 1; }
SA=$(kubectl get pod metrics-pod -n monitoring -o jsonpath='{.spec.serviceAccountName}')
[ "$SA" = "monitor-sa" ] || { echo "❌ Using '$SA', expected 'monitor-sa'"; exit 1; }
echo "✅ Passed"
