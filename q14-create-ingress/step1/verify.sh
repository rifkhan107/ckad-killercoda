#!/bin/bash
kubectl get ingress web-ingress &>/dev/null || { echo "❌ Ingress not found"; exit 1; }
[ "$(kubectl get ing web-ingress -o jsonpath='{.spec.rules[0].host}')" = "web.example.com" ] || { echo "❌ Wrong host"; exit 1; }
[ "$(kubectl get ing web-ingress -o jsonpath='{.spec.rules[0].http.paths[0].pathType}')" = "Prefix" ] || { echo "❌ Wrong pathType"; exit 1; }
[ "$(kubectl get ing web-ingress -o jsonpath='{.spec.rules[0].http.paths[0].backend.service.name}')" = "web-svc" ] || { echo "❌ Wrong backend service"; exit 1; }
[ "$(kubectl get ing web-ingress -o jsonpath='{.spec.rules[0].http.paths[0].backend.service.port.number}')" = "8080" ] || { echo "❌ Wrong backend port"; exit 1; }
echo "✅ Passed"
