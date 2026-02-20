# Task

Namespace `prod` has a ResourceQuota.

## Your Task

1. Check quota: `kubectl describe quota -n prod`
2. Create Pod `resource-pod` in `prod`:

| Field | Value |
|-------|-------|
| Image | `nginx:latest` |
| CPU request | at least `100m` |
| Memory request | at least `128Mi` |
| CPU limit | **half** of quota's `limits.cpu` |
| Memory limit | **half** of quota's `limits.memory` |

📖 [ResourceQuota](https://kubernetes.io/docs/concepts/policy/resource-quotas/)

---

<details>
<summary>💡 Hint</summary>

Quota has `limits.cpu: 2` and `limits.memory: 4Gi`, so use `cpu: 1` and `memory: 2Gi`.

</details>

<details>
<summary>📝 Solution</summary>

```bash
kubectl describe quota prod-quota -n prod
# limits.cpu: 2, limits.memory: 4Gi → half = 1, 2Gi
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
kubectl apply -f resource-pod.yaml
kubectl get pod resource-pod -n prod
```

</details>
