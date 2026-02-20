#!/bin/bash
kubectl get pod resource-pod -n prod &>/dev/null || { echo "❌ Pod not found in prod"; exit 1; }
kubectl get pod resource-pod -n prod -o jsonpath='{.spec.containers[0].image}' | grep -q nginx || { echo "❌ Wrong image"; exit 1; }
[ -n "$(kubectl get pod resource-pod -n prod -o jsonpath='{.spec.containers[0].resources.requests.cpu}')" ] || { echo "❌ No CPU request"; exit 1; }
[ -n "$(kubectl get pod resource-pod -n prod -o jsonpath='{.spec.containers[0].resources.requests.memory}')" ] || { echo "❌ No memory request"; exit 1; }
[ -n "$(kubectl get pod resource-pod -n prod -o jsonpath='{.spec.containers[0].resources.limits.cpu}')" ] || { echo "❌ No CPU limit"; exit 1; }
[ -n "$(kubectl get pod resource-pod -n prod -o jsonpath='{.spec.containers[0].resources.limits.memory}')" ] || { echo "❌ No memory limit"; exit 1; }
echo "✅ Passed"
