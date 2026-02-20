# Solution

```bash
kubectl create ingress web-ingress \
  --rule="web.example.com/=web-svc:8080" \
  --annotation="nginx.ingress.io/rewrite-target=/"
```

Or declaratively:
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
