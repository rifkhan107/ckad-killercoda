#!/bin/bash
kubectl get sa log-sa -n audit &>/dev/null || { echo "❌ SA 'log-sa' not found"; exit 1; }
kubectl get role log-role -n audit &>/dev/null || { echo "❌ Role 'log-role' not found"; exit 1; }
V=$(kubectl get role log-role -n audit -o jsonpath='{.rules[0].verbs[*]}')
echo "$V" | grep -q "get" && echo "$V" | grep -q "list" && echo "$V" | grep -q "watch" || { echo "❌ Missing verbs"; exit 1; }
kubectl get role log-role -n audit -o jsonpath='{.rules[0].resources[*]}' | grep -q "pods" || { echo "❌ Not targeting pods"; exit 1; }
kubectl get rolebinding log-rb -n audit &>/dev/null || { echo "❌ RoleBinding 'log-rb' not found"; exit 1; }
SA=$(kubectl get pod log-collector -n audit -o jsonpath='{.spec.serviceAccountName}' 2>/dev/null)
[ "$SA" = "log-sa" ] || { echo "❌ Pod using '$SA', expected 'log-sa'"; exit 1; }
echo "✅ Passed"
