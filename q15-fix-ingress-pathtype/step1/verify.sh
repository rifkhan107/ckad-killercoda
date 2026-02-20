#!/bin/bash
kubectl get ingress api-ingress &>/dev/null || { echo "❌ Ingress not found. Did you apply?"; exit 1; }
PT=$(kubectl get ing api-ingress -o jsonpath='{.spec.rules[0].http.paths[0].pathType}')
case "$PT" in Prefix|Exact|ImplementationSpecific) ;; *) echo "❌ Invalid pathType: $PT"; exit 1 ;; esac
[ "$(kubectl get ing api-ingress -o jsonpath='{.spec.rules[0].http.paths[0].path}')" = "/api" ] || { echo "❌ Path changed"; exit 1; }
echo "✅ Passed"
