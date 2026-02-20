#!/bin/bash
kubectl get deploy broken-app -n default &>/dev/null || { echo "❌ Deployment 'broken-app' not found"; exit 1; }
AVAIL=$(kubectl get deploy broken-app -n default -o jsonpath='{.status.availableReplicas}')
[ -n "$AVAIL" ] && [ "$AVAIL" -ge 1 ] || { echo "❌ broken-app has no available replicas"; exit 1; }
grep -q "apps/v1" /root/broken-deploy.yaml || { echo "❌ YAML still uses deprecated API"; exit 1; }
echo "✅ Q8 Passed: Broken deployment fixed and running"
