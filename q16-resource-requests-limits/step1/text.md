# Task

Namespace `prod` has a ResourceQuota.

**Your Task:**
1. Check the quota: `kubectl describe quota -n prod`
2. Create Pod `resource-pod` in `prod`:

| Field | Value |
|-------|-------|
| Image | `nginx:latest` |
| CPU request | at least `100m` |
| Memory request | at least `128Mi` |
| CPU limit | **half** of quota's `limits.cpu` |
| Memory limit | **half** of quota's `limits.memory` |

📖 [ResourceQuota](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
📖 [Resource Management](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
