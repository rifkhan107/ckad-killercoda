# Solution

Check quota first:
```bash
kubectl describe quota prod-quota -n prod
# limits.cpu: 2, limits.memory: 4Gi → half = 1 CPU, 2Gi
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
  namespace: prod
spec:
  containers:
    - name: web
      image: nginx:latest
      resources:
        requests:
          cpu: "100m"
          memory: "128Mi"
        limits:
          cpu: "1"
          memory: "2Gi"
```

```bash
kubectl apply -f /tmp/resource-pod.yaml
kubectl get pod resource-pod -n prod
```
