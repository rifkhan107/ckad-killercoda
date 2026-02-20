#!/bin/bash
kubectl get ingress web-ingress -n default &>/dev/null || { echo "❌ Ingress 'web-ingress' not found"; exit 1; }
HOST=$(kubectl get ingress web-ingress -n default -o jsonpath='{.spec.rules[0].host}')
[ "$HOST" = "web.example.com" ] || { echo "❌ Host is '$HOST', expected 'web.example.com'"; exit 1; }
PT=$(kubectl get ingress web-ingress -n default -o jsonpath='{.spec.rules[0].http.paths[0].pathType}')
[ "$PT" = "Prefix" ] || { echo "❌ PathType is '$PT', expected 'Prefix'"; exit 1; }
SVC=$(kubectl get ingress web-ingress -n default -o jsonpath='{.spec.rules[0].http.paths[0].backend.service.name}')
[ "$SVC" = "web-svc" ] || { echo "❌ Backend service is '$SVC', expected 'web-svc'"; exit 1; }
SPORT=$(kubectl get ingress web-ingress -n default -o jsonpath='{.spec.rules[0].http.paths[0].backend.service.port.number}')
[ "$SPORT" = "8080" ] || { echo "❌ Backend port is '$SPORT', expected 8080"; exit 1; }
echo "✅ Q14 Passed: Ingress created correctly"
