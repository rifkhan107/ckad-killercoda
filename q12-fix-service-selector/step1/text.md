# Task

- Deployment `web-deploy`: pods labeled `app=webapp, tier=frontend`
- Service `web-svc`: **wrong** selector `app=wrongapp`

## Your Task

Fix Service `web-svc` to select the correct pods.

```bash
kubectl get pods --show-labels
kubectl get endpoints web-svc    # empty = broken
```

📖 [Services](https://kubernetes.io/docs/concepts/services-networking/service/)

---

<details>
<summary>💡 Hint</summary>

Change the Service selector from `app: wrongapp` to `app: webapp`.

</details>

<details>
<summary>📝 Solution</summary>

```bash
kubectl edit svc web-svc
```

Change:
```yaml
spec:
  selector:
    app: webapp       # was: wrongapp
```

Verify:
```bash
kubectl get endpoints web-svc
# Should now show pod IPs
```

</details>
