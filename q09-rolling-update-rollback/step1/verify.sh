#!/bin/bash
IMG=$(kubectl get deploy app-v1 -o jsonpath='{.spec.template.spec.containers[0].image}')
[ "$IMG" = "nginx:1.20" ] || { echo "❌ Image is '$IMG', expected 'nginx:1.20' after rollback"; exit 1; }
REV=$(kubectl rollout history deploy app-v1 | grep -c "^[0-9]")
[ "$REV" -ge 2 ] || { echo "❌ Only $REV revision(s). Did you update first?"; exit 1; }
echo "✅ Passed"
