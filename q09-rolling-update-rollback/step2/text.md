# Solution

```bash
# Update
kubectl set image deploy/app-v1 web=nginx:1.25
kubectl rollout status deploy app-v1

# Check history
kubectl rollout history deploy app-v1

# Rollback
kubectl rollout undo deploy app-v1

# Verify
kubectl get deploy app-v1 -o jsonpath='{.spec.template.spec.containers[0].image}'
# Output: nginx:1.20
```
