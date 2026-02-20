# Task

Deployment `app-v1` uses `nginx:1.20`.

## Your Task

1. Update to `nginx:1.25`
2. Verify rolling update completes
3. **Rollback** to previous revision
4. Verify image is `nginx:1.20` again

📖 [Rolling Updates](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-update-deployment)

---

<details>
<summary>💡 Hint</summary>

```bash
kubectl set image deploy/app-v1 web=nginx:1.25
kubectl rollout undo deploy app-v1
```

</details>

<details>
<summary>📝 Solution</summary>

```bash
# Update
kubectl set image deploy/app-v1 web=nginx:1.25
kubectl rollout status deploy app-v1

# Check history
kubectl rollout history deploy app-v1

# Rollback
kubectl rollout undo deploy app-v1
kubectl rollout status deploy app-v1

# Verify image is back to 1.20
kubectl get deploy app-v1 -o jsonpath='{.spec.template.spec.containers[0].image}'
# Output: nginx:1.20
```

</details>
