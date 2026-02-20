# Task

Deployment `api-np-server`: pods labeled `app=api`, port `9090`.

## Create Service `api-nodeport`:

| Field | Value |
|-------|-------|
| Type | `NodePort` |
| Selector | `app=api` |
| Port | `80` |
| TargetPort | `9090` |

📖 [NodePort](https://kubernetes.io/docs/concepts/services-networking/service/#nodeport)

---

<details>
<summary>💡 Hint</summary>

```bash
kubectl expose deploy api-np-server --name=api-nodeport \
  --type=NodePort --port=80 --target-port=9090
```

</details>

<details>
<summary>📝 Solution</summary>

Imperative:
```bash
kubectl expose deploy api-np-server --name=api-nodeport \
  --type=NodePort --port=80 --target-port=9090
```

Or declarative:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: api-nodeport
spec:
  type: NodePort
  selector:
    app: api
  ports:
    - port: 80
      targetPort: 9090
```

```bash
kubectl get svc api-nodeport
```

</details>
