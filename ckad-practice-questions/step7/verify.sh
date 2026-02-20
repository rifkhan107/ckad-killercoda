#!/bin/bash
FE=$(kubectl get pod frontend -n network-demo -o jsonpath='{.metadata.labels.role}')
[ "$FE" = "frontend" ] || { echo "❌ frontend role='$FE', expected 'frontend'"; exit 1; }
BE=$(kubectl get pod backend -n network-demo -o jsonpath='{.metadata.labels.role}')
[ "$BE" = "backend" ] || { echo "❌ backend role='$BE', expected 'backend'"; exit 1; }
DB=$(kubectl get pod database -n network-demo -o jsonpath='{.metadata.labels.role}')
[ "$DB" = "db" ] || { echo "❌ database role='$DB', expected 'db'"; exit 1; }
echo "✅ Q7 Passed: Pod labels fixed, NetworkPolicy chain enabled"
