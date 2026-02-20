#!/bin/bash
RUN_AS=$(kubectl get deploy secure-app -n default -o jsonpath='{.spec.template.spec.securityContext.runAsUser}')
[ "$RUN_AS" = "1000" ] || { echo "❌ Pod runAsUser is '$RUN_AS', expected 1000"; exit 1; }
CAPS=$(kubectl get deploy secure-app -n default -o jsonpath='{.spec.template.spec.containers[0].securityContext.capabilities.add[*]}')
echo "$CAPS" | grep -qi "NET_ADMIN" || { echo "❌ Container missing NET_ADMIN capability"; exit 1; }
echo "✅ Q11 Passed: Security context configured correctly"
