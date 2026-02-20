#!/bin/bash
S=$(kubectl get svc web-svc -o jsonpath='{.spec.selector.app}')
[ "$S" = "webapp" ] || { echo "❌ Selector: app='$S', expected 'webapp'"; exit 1; }
EP=$(kubectl get endpoints web-svc -o jsonpath='{.subsets[0].addresses}')
[ -n "$EP" ] || { echo "❌ No endpoints"; exit 1; }
echo "✅ Passed"
