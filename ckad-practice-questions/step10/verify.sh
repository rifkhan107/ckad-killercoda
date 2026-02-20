#!/bin/bash
PROBE=$(kubectl get deploy api-deploy -n default -o jsonpath='{.spec.template.spec.containers[0].readinessProbe}')
[ -n "$PROBE" ] || { echo "❌ No readinessProbe on api-deploy"; exit 1; }
P=$(kubectl get deploy api-deploy -n default -o jsonpath='{.spec.template.spec.containers[0].readinessProbe.httpGet.path}')
[ "$P" = "/ready" ] || { echo "❌ Probe path is '$P', expected '/ready'"; exit 1; }
PORT=$(kubectl get deploy api-deploy -n default -o jsonpath='{.spec.template.spec.containers[0].readinessProbe.httpGet.port}')
[ "$PORT" = "8080" ] || { echo "❌ Probe port is '$PORT', expected 8080"; exit 1; }
IDS=$(kubectl get deploy api-deploy -n default -o jsonpath='{.spec.template.spec.containers[0].readinessProbe.initialDelaySeconds}')
[ "$IDS" = "5" ] || { echo "❌ initialDelaySeconds is '$IDS', expected 5"; exit 1; }
PS=$(kubectl get deploy api-deploy -n default -o jsonpath='{.spec.template.spec.containers[0].readinessProbe.periodSeconds}')
[ "$PS" = "10" ] || { echo "❌ periodSeconds is '$PS', expected 10"; exit 1; }
echo "✅ Q10 Passed: Readiness probe configured correctly"
