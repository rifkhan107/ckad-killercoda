# Solution

```bash
kubectl expose deploy api-np-server \
  --name=api-nodeport \
  --type=NodePort \
  --port=80 \
  --target-port=9090

# Or imperatively:
kubectl create service nodeport api-nodeport \
  --tcp=80:9090
# Then edit selector to app=api
```

Or declaratively:
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
