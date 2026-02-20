# Task

Deployment `secure-app` has no security context.

**Your Task:**
1. Set **Pod-level** `runAsUser: 1000`
2. Add **container-level** capability `NET_ADMIN` to container `app`

⚠️ Capabilities are set at container level, not Pod level.

📖 [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
