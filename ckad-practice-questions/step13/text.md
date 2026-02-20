# Q13 – Create NodePort Service

In namespace `default`, Deployment `api-np-server` exists with:
- Pods labeled `app=api`
- Container port `9090`

## Your Task

Create a Service named `api-nodeport` that:

| Field | Value |
|-------|-------|
| Type | `NodePort` |
| Selector | `app=api` |
| Service port | `80` |
| Target port | `9090` |

## Docs

- [NodePort Services](https://kubernetes.io/docs/concepts/services-networking/service/#nodeport)
