#!/bin/bash

# Check secret exists
kubectl get secret db-credentials -n default &>/dev/null || {
  echo "❌ Secret 'db-credentials' not found in default namespace"
  exit 1
}

# Check secret has correct keys
DB_USER=$(kubectl get secret db-credentials -n default -o jsonpath='{.data.DB_USER}' | base64 -d 2>/dev/null)
DB_PASS=$(kubectl get secret db-credentials -n default -o jsonpath='{.data.DB_PASS}' | base64 -d 2>/dev/null)

[ "$DB_USER" = "admin" ] || {
  echo "❌ Secret key DB_USER does not have correct value"
  exit 1
}

[ "$DB_PASS" = "Secret123!" ] || {
  echo "❌ Secret key DB_PASS does not have correct value"
  exit 1
}

# Check deployment uses secretKeyRef
DEPLOY_YAML=$(kubectl get deploy api-server -n default -o yaml)

echo "$DEPLOY_YAML" | grep -q "secretKeyRef" || {
  echo "❌ Deployment api-server is not using secretKeyRef"
  exit 1
}

echo "$DEPLOY_YAML" | grep -q "db-credentials" || {
  echo "❌ Deployment api-server is not referencing secret 'db-credentials'"
  exit 1
}

echo "✅ Q1 Passed: Secret created and Deployment updated correctly"
