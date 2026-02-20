#!/bin/bash
kubectl get deploy broken-app &>/dev/null || { echo "❌ Deployment not found"; exit 1; }
A=$(kubectl get deploy broken-app -o jsonpath='{.status.availableReplicas}')
[ -n "$A" ] && [ "$A" -ge 1 ] || { echo "❌ No available replicas"; exit 1; }
grep -q "apps/v1" /root/broken-deploy.yaml || { echo "❌ Still uses deprecated API"; exit 1; }
echo "✅ Passed"
