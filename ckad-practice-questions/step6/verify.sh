#!/bin/bash
REPLICAS=$(kubectl get deploy web-app -n default -o jsonpath='{.spec.replicas}')
[ "$REPLICAS" = "8" ] || { echo "❌ web-app has $REPLICAS replicas, expected 8"; exit 1; }
kubectl get deploy web-app-canary -n default &>/dev/null || { echo "❌ Deployment 'web-app-canary' not found"; exit 1; }
CR=$(kubectl get deploy web-app-canary -n default -o jsonpath='{.spec.replicas}')
[ "$CR" = "2" ] || { echo "❌ web-app-canary has $CR replicas, expected 2"; exit 1; }
CL=$(kubectl get deploy web-app-canary -n default -o jsonpath='{.spec.template.metadata.labels.app}')
[ "$CL" = "webapp" ] || { echo "❌ web-app-canary pods missing label app=webapp"; exit 1; }
echo "✅ Q6 Passed: Canary deployment with 8:2 traffic split"
