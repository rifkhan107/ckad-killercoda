# Task

Existing: Deployment `web-deploy` + Service `web-svc` on port `8080`.

**Create Ingress `web-ingress`:**

| Field | Value |
|-------|-------|
| Host | `web.example.com` |
| Path | `/` |
| PathType | `Prefix` |
| Backend | `web-svc:8080` |
| API Version | `networking.k8s.io/v1` |

📖 [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
