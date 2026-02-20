#!/bin/bash
kubectl get svc api-nodeport -n default &>/dev/null || { echo "❌ Service 'api-nodeport' not found"; exit 1; }
TYPE=$(kubectl get svc api-nodeport -n default -o jsonpath='{.spec.type}')
[ "$TYPE" = "NodePort" ] || { echo "❌ Service type is '$TYPE', expected 'NodePort'"; exit 1; }
PORT=$(kubectl get svc api-nodeport -n default -o jsonpath='{.spec.ports[0].port}')
[ "$PORT" = "80" ] || { echo "❌ Service port is '$PORT', expected 80"; exit 1; }
TP=$(kubectl get svc api-nodeport -n default -o jsonpath='{.spec.ports[0].targetPort}')
[ "$TP" = "9090" ] || { echo "❌ Target port is '$TP', expected 9090"; exit 1; }
SEL=$(kubectl get svc api-nodeport -n default -o jsonpath='{.spec.selector.app}')
[ "$SEL" = "api" ] || { echo "❌ Selector is app='$SEL', expected 'api'"; exit 1; }
echo "✅ Q13 Passed: NodePort service created correctly"
