#!/bin/bash
[ "$(kubectl get deploy web-app -o jsonpath='{.spec.replicas}')" = "8" ] || { echo "❌ web-app replicas != 8"; exit 1; }
kubectl get deploy web-app-canary &>/dev/null || { echo "❌ web-app-canary not found"; exit 1; }
[ "$(kubectl get deploy web-app-canary -o jsonpath='{.spec.replicas}')" = "2" ] || { echo "❌ canary replicas != 2"; exit 1; }
[ "$(kubectl get deploy web-app-canary -o jsonpath='{.spec.template.metadata.labels.app}')" = "webapp" ] || { echo "❌ canary missing app=webapp label"; exit 1; }
echo "✅ Passed"
