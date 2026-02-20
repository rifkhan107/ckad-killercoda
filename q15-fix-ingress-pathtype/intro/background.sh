#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
cat > /root/fix-ingress.yaml << 'YAML'
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: api-ingress
  namespace: default
spec:
  rules:
    - http:
        paths:
          - path: /api
            pathType: InvalidType
            backend:
              service:
                name: api-svc
                port:
                  number: 8080
YAML
touch /tmp/.lab-setup-done
