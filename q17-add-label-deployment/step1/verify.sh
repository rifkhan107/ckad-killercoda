#!/bin/bash
# Check pod template has the label
TMPL_LABEL=$(kubectl get deployment web-app -n web-ns \
  -o jsonpath='{.spec.template.metadata.labels.tier}' 2>/dev/null)
[ "$TMPL_LABEL" = "frontend" ] || {
  echo "❌ Deployment pod template is missing label tier=frontend (got: '${TMPL_LABEL}')"; exit 1
}

# Check at least one running pod carries the label
READY=$(kubectl get pods -n web-ns -l tier=frontend --field-selector=status.phase=Running \
  --no-headers 2>/dev/null | wc -l)
[ "$READY" -ge 1 ] || {
  echo "❌ No running pods found with label tier=frontend (rollout may still be in progress — wait and re-check)"; exit 1
}

echo "✅ Passed"
