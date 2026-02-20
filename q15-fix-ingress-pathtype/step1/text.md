# Task

File `/root/fix-ingress.yaml` fails to apply.

**Your Task:**
1. Try: `kubectl apply -f /root/fix-ingress.yaml` — note the error
2. Fix `pathType` to a valid value: `Prefix`, `Exact`, or `ImplementationSpecific`
3. Apply the fixed manifest

📖 [Ingress Path Types](https://kubernetes.io/docs/concepts/services-networking/ingress/#path-types)
