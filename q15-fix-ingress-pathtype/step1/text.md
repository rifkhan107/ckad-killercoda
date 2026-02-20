# Task

File `/root/fix-ingress.yaml` fails to apply due to invalid `pathType`.

## Your Task

1. Try: `kubectl apply -f /root/fix-ingress.yaml` — note the error
2. Fix `pathType` to a valid value
3. Apply the fixed manifest

Valid values: `Prefix`, `Exact`, `ImplementationSpecific`

📖 [Ingress Path Types](https://kubernetes.io/docs/concepts/services-networking/ingress/#path-types)

---

<details>
<summary>💡 Hint</summary>

Change `pathType: InvalidType` to `pathType: Prefix`.

</details>

<details>
<summary>📝 Solution</summary>

```bash
vi /root/fix-ingress.yaml
```

Change `pathType: InvalidType` → `pathType: Prefix`:
```yaml
- path: /api
  pathType: Prefix      # was InvalidType
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

</details>
