# Q9 – Perform Rolling Update and Rollback

In namespace `default`, Deployment `app-v1` exists with image `nginx:1.20`.

## Your Task

1. Update the Deployment to use image `nginx:1.25`
2. Verify the rolling update completes successfully
3. **Rollback** to the previous revision
4. Verify the rollback completed (image should be `nginx:1.20` again)

## Hints

<details>
<summary>💡 Hint</summary>

```bash
kubectl set image deploy/app-v1 web=nginx:1.25
kubectl rollout status deploy app-v1
kubectl rollout undo deploy app-v1
```
</details>

## Docs

- [Rolling Updates](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-update-deployment)
