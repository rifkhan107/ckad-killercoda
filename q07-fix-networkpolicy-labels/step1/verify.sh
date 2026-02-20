#!/bin/bash
[ "$(kubectl get pod frontend -n network-demo -o jsonpath='{.metadata.labels.role}')" = "frontend" ] || { echo "❌ frontend role wrong"; exit 1; }
[ "$(kubectl get pod backend -n network-demo -o jsonpath='{.metadata.labels.role}')" = "backend" ] || { echo "❌ backend role wrong"; exit 1; }
[ "$(kubectl get pod database -n network-demo -o jsonpath='{.metadata.labels.role}')" = "db" ] || { echo "❌ database role wrong"; exit 1; }
echo "✅ Passed"
