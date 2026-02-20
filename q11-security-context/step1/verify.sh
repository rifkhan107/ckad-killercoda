#!/bin/bash
R=$(kubectl get deploy secure-app -o jsonpath='{.spec.template.spec.securityContext.runAsUser}')
[ "$R" = "1000" ] || { echo "❌ runAsUser: '$R', expected 1000"; exit 1; }
C=$(kubectl get deploy secure-app -o jsonpath='{.spec.template.spec.containers[0].securityContext.capabilities.add[*]}')
echo "$C" | grep -qi "NET_ADMIN" || { echo "❌ Missing NET_ADMIN capability"; exit 1; }
echo "✅ Passed"
