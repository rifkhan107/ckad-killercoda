# Solution

```bash
vi /root/broken-deploy.yaml
```

Fixed YAML:
```yaml
apiVersion: apps/v1          # was extensions/v1beta1
kind: Deployment
metadata:
  name: broken-app
  namespace: default
spec:
  replicas: 2
  selector:                   # was missing entirely
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
