# Q12 – Fix Service Selector

In namespace `default`:

- Deployment `web-deploy` exists with Pods labeled `app=webapp, tier=frontend`
- Service `web-svc` exists but has **incorrect** selector `app=wrongapp`

## Your Task

Update Service `web-svc` to correctly select Pods from Deployment `web-deploy`.

## Verification

```bash
kubectl get endpoints web-svc
# Should show Pod IPs (not empty)
```

## Docs

- [Services](https://kubernetes.io/docs/concepts/services-networking/service/)
