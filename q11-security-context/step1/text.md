# Task

Deployment `secure-app` has no security context.

## Your Task

1. Set **Pod-level** `runAsUser: 1000`
2. Add **container-level** capability `NET_ADMIN` to container `app`

⚠️ Capabilities are set at container level, not Pod level.

> **Note:** This deployment uses `nginxinc/nginx-unprivileged` — an image designed to run as a non-root user on port `8080`. Unlike `nginx:latest`, it won't crash when `runAsUser` is set.

📖 [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

---

<details>
<summary>💡 Hint</summary>

Pod-level: `spec.securityContext.runAsUser`
Container-level: `spec.containers[].securityContext.capabilities.add`

</details>

<details>
<summary>📝 Solution</summary>

```bash
kubectl edit deploy secure-app
```

```yaml
spec:
  template:
    spec:
      securityContext:          # Pod-level
        runAsUser: 1000
      containers:
        - name: app
          image: nginxinc/nginx-unprivileged
          ports:
            - containerPort: 8080
          securityContext:      # Container-level
            capabilities:
              add: ["NET_ADMIN"]
```

```bash
kubectl rollout status deploy secure-app
```

</details>
