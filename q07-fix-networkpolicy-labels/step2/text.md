# Solution

```bash
kubectl label pod frontend -n network-demo role=frontend --overwrite
kubectl label pod backend -n network-demo role=backend --overwrite
kubectl label pod database -n network-demo role=db --overwrite
```

Verify:
```bash
kubectl get pods -n network-demo --show-labels
```

**Key**: Use `kubectl label --overwrite` for quick label fixes.
