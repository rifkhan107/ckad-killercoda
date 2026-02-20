# Q16 – Add Resource Requests and Limits to Pod

In namespace `prod`, a ResourceQuota exists that sets resource limits.

## Your Task

1. Check the ResourceQuota: `kubectl describe quota -n prod`
2. Create a Pod named `resource-pod` with:

| Field | Value |
|-------|-------|
| Image | `nginx:latest` |
| CPU request | at least `100m` |
| Memory request | at least `128Mi` |
| CPU limit | **half** of the quota's `limits.cpu` |
| Memory limit | **half** of the quota's `limits.memory` |

> 📝 The quota has `limits.cpu: 2` and `limits.memory: 4Gi`, so use `cpu: 1` and `memory: 2Gi` for limits.

## Docs

- [ResourceQuota](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
- [Resource Management](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
