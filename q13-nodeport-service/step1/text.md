# Task

Deployment `api-np-server`: pods labeled `app=api`, port `9090`.

**Create Service `api-nodeport`:**

| Field | Value |
|-------|-------|
| Type | `NodePort` |
| Selector | `app=api` |
| Port | `80` |
| TargetPort | `9090` |

📖 [NodePort](https://kubernetes.io/docs/concepts/services-networking/service/#nodeport)
