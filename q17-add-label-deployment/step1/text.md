# Task

Deployment `web-app` in namespace `web-ns` exists but its pod template is missing a label.

## Your Task

Add label `tier=frontend` to the **pod template** of deployment `web-app` in namespace `web-ns`.

The pods created by the deployment must also carry the label (they will after a rollout).

```bash
# Inspect current state
kubectl get deployment web-app -n web-ns -o yaml | grep -A5 "template:"
kubectl get pods -n web-ns --show-labels
```

> **Common CKAD trap:** Adding the label only to the Deployment object (`kubectl label deployment`) does **not** add it to pods. You must update `spec.template.metadata.labels`.

📖 [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

---

<details>
<summary>💡 Hint</summary>

Use `kubectl patch` to update the pod template labels without touching `selector.matchLabels`:

```bash
kubectl patch deployment web-app -n web-ns \
  -p '{"spec":{"template":{"metadata":{"labels":{"tier":"frontend"}}}}}'
```

Or export → edit → apply:
```bash
kubectl get deployment web-app -n web-ns -o yaml > /root/web-app.yaml
# add tier: frontend under spec.template.metadata.labels
kubectl apply -f /root/web-app.yaml
```

</details>

<details>
<summary>📝 Solution</summary>

**Option 1 — kubectl patch (fastest in exam):**
```bash
kubectl patch deployment web-app -n web-ns \
  -p '{"spec":{"template":{"metadata":{"labels":{"tier":"frontend"}}}}}'
```

**Option 2 — export → edit → apply:**
```bash
kubectl get deployment web-app -n web-ns -o yaml > /root/web-app.yaml
vi /root/web-app.yaml
# Under spec.template.metadata.labels add:  tier: frontend
kubectl apply -f /root/web-app.yaml
```

**Verify:**
```bash
kubectl get deployment web-app -n web-ns \
  -o jsonpath='{.spec.template.metadata.labels}'
kubectl get pods -n web-ns --show-labels
```

**Key distinction:**
| Command | What it labels |
|---------|---------------|
| `kubectl label deployment web-app tier=frontend` | The Deployment object only |
| `kubectl patch deployment ... spec.template.metadata.labels` | The pod template → new pods get the label |

</details>
