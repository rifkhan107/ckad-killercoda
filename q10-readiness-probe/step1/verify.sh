#!/bin/bash
P=$(kubectl get deploy api-deploy -o jsonpath='{.spec.template.spec.containers[0].readinessProbe.httpGet.path}')
[ "$P" = "/ready" ] || { echo "❌ Probe path: '$P', expected '/ready'"; exit 1; }
PORT=$(kubectl get deploy api-deploy -o jsonpath='{.spec.template.spec.containers[0].readinessProbe.httpGet.port}')
[ "$PORT" = "8080" ] || { echo "❌ Probe port: $PORT, expected 8080"; exit 1; }
IDS=$(kubectl get deploy api-deploy -o jsonpath='{.spec.template.spec.containers[0].readinessProbe.initialDelaySeconds}')
[ "$IDS" = "5" ] || { echo "❌ initialDelaySeconds: $IDS, expected 5"; exit 1; }
PS=$(kubectl get deploy api-deploy -o jsonpath='{.spec.template.spec.containers[0].readinessProbe.periodSeconds}')
[ "$PS" = "10" ] || { echo "❌ periodSeconds: $PS, expected 10"; exit 1; }
echo "✅ Passed"
