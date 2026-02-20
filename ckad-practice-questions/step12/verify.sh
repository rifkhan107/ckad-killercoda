#!/bin/bash
SEL=$(kubectl get svc web-svc -n default -o jsonpath='{.spec.selector.app}')
[ "$SEL" = "webapp" ] || { echo "❌ Service selector is app='$SEL', expected 'webapp'"; exit 1; }
EP=$(kubectl get endpoints web-svc -n default -o jsonpath='{.subsets[0].addresses}')
[ -n "$EP" ] || { echo "❌ Service web-svc has no endpoints"; exit 1; }
echo "✅ Q12 Passed: Service selector fixed, endpoints connected"
