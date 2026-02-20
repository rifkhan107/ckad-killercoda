#!/bin/bash

kubectl get sa log-sa -n audit &>/dev/null || {
  echo "❌ ServiceAccount 'log-sa' not found in audit namespace"
  exit 1
}

kubectl get role log-role -n audit &>/dev/null || {
  echo "❌ Role 'log-role' not found in audit namespace"
  exit 1
}

VERBS=$(kubectl get role log-role -n audit -o jsonpath='{.rules[0].verbs[*]}')
echo "$VERBS" | grep -q "get" && echo "$VERBS" | grep -q "list" && echo "$VERBS" | grep -q "watch" || {
  echo "❌ Role 'log-role' missing required verbs (get, list, watch)"
  exit 1
}

RESOURCES=$(kubectl get role log-role -n audit -o jsonpath='{.rules[0].resources[*]}')
echo "$RESOURCES" | grep -q "pods" || {
  echo "❌ Role 'log-role' is not targeting 'pods' resource"
  exit 1
}

kubectl get rolebinding log-rb -n audit &>/dev/null || {
  echo "❌ RoleBinding 'log-rb' not found in audit namespace"
  exit 1
}

SA=$(kubectl get pod log-collector -n audit -o jsonpath='{.spec.serviceAccountName}' 2>/dev/null)
[ "$SA" = "log-sa" ] || {
  echo "❌ Pod log-collector is using ServiceAccount '$SA', expected 'log-sa'"
  exit 1
}

echo "✅ Q3 Passed: RBAC configured and Pod updated correctly"
