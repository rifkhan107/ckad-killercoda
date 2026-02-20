# Task

File `/root/broken-deploy.yaml` fails to apply. It has:
1. **Deprecated** API version (`extensions/v1beta1`)
2. **Missing** `selector` field
3. Selector doesn't match template labels

## Your Task

1. Fix to use `apiVersion: apps/v1`
2. Add `selector.matchLabels` matching template labels
3. Apply: `kubectl apply -f /root/broken-deploy.yaml`

```bash
cat /root/broken-deploy.yaml
kubectl apply -f /root/broken-deploy.yaml  # see the error
```

📖 [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

---

<details>
<summary>💡 Hint</summary>

In `apps/v1`, `selector` is required and must match `template.metadata.labels`.

</details>

<details>
<summary>📝 Solution</summary>

```bash
vi /root/broken-deploy.yaml
```

Fixed YAML:
```yaml
apiVersion: apps/v1              # was extensions/v1beta1
kind: Deployment
metadata:
  name: broken-app
  namespace: default
spec:
  replicas: 2
  selector:                      # was missing
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
        - name: web
          image: nginx
          ports:
            - containerPort: 80
```

```bash
kubectl apply -f /root/broken-deploy.yaml
kubectl rollout status deploy broken-app
```

</details>
