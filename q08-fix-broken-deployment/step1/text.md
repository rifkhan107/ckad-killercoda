# Task

File `/root/broken-deploy.yaml` fails to apply. It has:
1. **Deprecated** API version
2. **Missing** `selector` field
3. Selector doesn't match template labels

**Your Task:**
1. Fix to use `apiVersion: apps/v1`
2. Add `selector.matchLabels` matching the template labels
3. Apply and verify: `kubectl apply -f /root/broken-deploy.yaml`

📖 [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
