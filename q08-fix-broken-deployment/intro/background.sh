#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
cat > /root/broken-deploy.yaml << 'YAML'
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: broken-app
  namespace: default
spec:
  replicas: 2
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
YAML
touch /tmp/.lab-setup-done
