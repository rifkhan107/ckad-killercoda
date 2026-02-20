# Q14 – Create Ingress Resource

In namespace `default`, the following resources exist:

- Deployment `web-deploy` with Pods labeled `app=web`
- Service `web-svc` on port `8080`

## Your Task

Create an Ingress named `web-ingress` that:

| Field | Value |
|-------|-------|
| Host | `web.example.com` |
| Path | `/` |
| PathType | `Prefix` |
| Backend Service | `web-svc` |
| Backend Port | `8080` |
| API Version | `networking.k8s.io/v1` |

## Docs

- [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
