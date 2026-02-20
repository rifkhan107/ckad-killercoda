#!/bin/bash
kubectl get ingress api-ingress -n default &>/dev/null || { echo "❌ Ingress 'api-ingress' not found. Did you apply the fixed YAML?"; exit 1; }
PT=$(kubectl get ingress api-ingress -n default -o jsonpath='{.spec.rules[0].http.paths[0].pathType}')
case "$PT" in
  Prefix|Exact|ImplementationSpecific) ;;
  *) echo "❌ PathType is '$PT', must be Prefix, Exact, or ImplementationSpecific"; exit 1 ;;
esac
PATH_VAL=$(kubectl get ingress api-ingress -n default -o jsonpath='{.spec.rules[0].http.paths[0].path}')
[ "$PATH_VAL" = "/api" ] || { echo "❌ Path is '$PATH_VAL', expected '/api'"; exit 1; }
echo "✅ Q15 Passed: Ingress pathType fixed and applied"
