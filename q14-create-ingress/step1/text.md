# Task

Existing: Deployment `web-deploy` + Service `web-svc` on port `8080`.

## Create Ingress `web-ingress`:

| Field | Value |
|-------|-------|
| Host | `web.example.com` |
| Path | `/` |
| PathType | `Prefix` |
| Backend | `web-svc:8080` |

📖 [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)

---

<details>
<summary>💡 Hint</summary>

```bash
kubectl create ingress web-ingress \
  --rule="web.example.com/=web-svc:8080"
```

</details>

<details>
<summary>📝 Solution</summary>

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-ingress
spec:
  rules:
    - host: web.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web-svc
                port:
                  number: 8080
```

```bash
kubectl apply -f ingress.yaml
kubectl get ingress web-ingress
```

</details>
