#!/bin/bash
kubectl get pod resource-pod -n prod &>/dev/null || { echo "❌ Pod 'resource-pod' not found in prod namespace"; exit 1; }
IMAGE=$(kubectl get pod resource-pod -n prod -o jsonpath='{.spec.containers[0].image}')
echo "$IMAGE" | grep -q "nginx" || { echo "❌ Image is '$IMAGE', expected nginx:latest"; exit 1; }
CPU_REQ=$(kubectl get pod resource-pod -n prod -o jsonpath='{.spec.containers[0].resources.requests.cpu}')
[ -n "$CPU_REQ" ] || { echo "❌ CPU request not set"; exit 1; }
MEM_REQ=$(kubectl get pod resource-pod -n prod -o jsonpath='{.spec.containers[0].resources.requests.memory}')
[ -n "$MEM_REQ" ] || { echo "❌ Memory request not set"; exit 1; }
CPU_LIM=$(kubectl get pod resource-pod -n prod -o jsonpath='{.spec.containers[0].resources.limits.cpu}')
[ -n "$CPU_LIM" ] || { echo "❌ CPU limit not set"; exit 1; }
MEM_LIM=$(kubectl get pod resource-pod -n prod -o jsonpath='{.spec.containers[0].resources.limits.memory}')
[ -n "$MEM_LIM" ] || { echo "❌ Memory limit not set"; exit 1; }
echo "✅ Q16 Passed: Pod with resource requests and limits created"
