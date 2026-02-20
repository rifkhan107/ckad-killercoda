# Solution

Investigate:
```bash
kubectl get rolebindings -n monitoring -o wide
# monitor-binding → metrics-reader → monitor-sa ✓
# admin-binding → full-access → admin-sa (overkill)
# wrong-sa has NO binding → that's why it fails
```

Fix:
```bash
kubectl get pod metrics-pod -n monitoring -o yaml > /tmp/metrics-pod.yaml
# Change serviceAccountName to monitor-sa
vi /tmp/metrics-pod.yaml
kubectl delete pod metrics-pod -n monitoring
kubectl apply -f /tmp/metrics-pod.yaml
```

**Key**: `monitor-sa` → `metrics-reader` → pod get/list/watch permissions.
