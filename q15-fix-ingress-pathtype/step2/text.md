# Solution

```bash
vi /root/fix-ingress.yaml
```

Change `pathType: InvalidType` to `pathType: Prefix`:
```yaml
- path: /api
  pathType: Prefix    # was InvalidType
  backend:
    service:
      name: api-svc
      port:
        number: 8080
```

```bash
kubectl apply -f /root/fix-ingress.yaml
kubectl get ingress api-ingress
```

**Valid values**: `Prefix`, `Exact`, `ImplementationSpecific`
