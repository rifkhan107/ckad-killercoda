#!/bin/bash
IMAGE=$(kubectl get deploy app-v1 -n default -o jsonpath='{.spec.template.spec.containers[0].image}')
[ "$IMAGE" = "nginx:1.20" ] || { echo "❌ Image is '$IMAGE', expected 'nginx:1.20' after rollback"; exit 1; }
REVISIONS=$(kubectl rollout history deploy app-v1 -n default | grep -c "^[0-9]")
[ "$REVISIONS" -ge 2 ] || { echo "❌ Only $REVISIONS revision(s). Did you perform the update first?"; exit 1; }
echo "✅ Q9 Passed: Rolling update and rollback completed"
