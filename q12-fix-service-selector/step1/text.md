# Task

- Deployment `web-deploy`: pods labeled `app=webapp, tier=frontend`
- Service `web-svc`: **wrong** selector `app=wrongapp`

**Your Task:** Fix Service `web-svc` to select the correct pods.

```bash
kubectl get pods --show-labels
kubectl get endpoints web-svc    # should be empty
```

📖 [Services](https://kubernetes.io/docs/concepts/services-networking/service/)
