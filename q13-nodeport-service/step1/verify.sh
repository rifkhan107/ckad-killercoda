#!/bin/bash
kubectl get svc api-nodeport &>/dev/null || { echo "❌ Service not found"; exit 1; }
[ "$(kubectl get svc api-nodeport -o jsonpath='{.spec.type}')" = "NodePort" ] || { echo "❌ Not NodePort type"; exit 1; }
[ "$(kubectl get svc api-nodeport -o jsonpath='{.spec.ports[0].port}')" = "80" ] || { echo "❌ Port != 80"; exit 1; }
[ "$(kubectl get svc api-nodeport -o jsonpath='{.spec.ports[0].targetPort}')" = "9090" ] || { echo "❌ TargetPort != 9090"; exit 1; }
[ "$(kubectl get svc api-nodeport -o jsonpath='{.spec.selector.app}')" = "api" ] || { echo "❌ Wrong selector"; exit 1; }
echo "✅ Passed"
