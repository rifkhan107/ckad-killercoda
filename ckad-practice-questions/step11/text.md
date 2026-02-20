# Q11 – Configure Pod and Container Security Context

In namespace `default`, Deployment `secure-app` exists **without** any security context.

## Your Task

1. Set **Pod-level** `runAsUser: 1000`
2. Add **container-level** capability `NET_ADMIN` to the container named `app`

> ⚠️ Capabilities are set at the **container** level, not the Pod level.

## Hints

<details>
<summary>💡 Hint</summary>

```yaml
spec:
  securityContext:        # Pod-level
    runAsUser: 1000
  containers:
    - name: app
      securityContext:    # Container-level
        capabilities:
          add: ["NET_ADMIN"]
```
</details>

## Docs

- [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
