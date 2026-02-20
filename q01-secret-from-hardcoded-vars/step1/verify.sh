#!/bin/bash
kubectl get secret db-credentials -n default &>/dev/null || { echo "❌ Secret 'db-credentials' not found"; exit 1; }
U=$(kubectl get secret db-credentials -n default -o jsonpath='{.data.DB_USER}' | base64 -d 2>/dev/null)
P=$(kubectl get secret db-credentials -n default -o jsonpath='{.data.DB_PASS}' | base64 -d 2>/dev/null)
[ "$U" = "admin" ] || { echo "❌ DB_USER incorrect"; exit 1; }
[ "$P" = "Secret123!" ] || { echo "❌ DB_PASS incorrect"; exit 1; }
Y=$(kubectl get deploy api-server -n default -o yaml)
echo "$Y" | grep -q "secretKeyRef" || { echo "❌ Not using secretKeyRef"; exit 1; }
echo "$Y" | grep -q "db-credentials" || { echo "❌ Not referencing db-credentials"; exit 1; }
echo "✅ Passed"
