#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
kubectl create ns network-demo
kubectl apply -f - <<'M'
apiVersion: v1
kind: Pod
metadata: { name: frontend, namespace: network-demo, labels: { role: wrong-frontend } }
spec: { containers: [{ name: fe, image: "nginx:alpine", ports: [{ containerPort: 80 }] }] }
---
apiVersion: v1
kind: Pod
metadata: { name: backend, namespace: network-demo, labels: { role: wrong-backend } }
spec: { containers: [{ name: be, image: "nginx:alpine", ports: [{ containerPort: 80 }] }] }
---
apiVersion: v1
kind: Pod
metadata: { name: database, namespace: network-demo, labels: { role: wrong-db } }
spec: { containers: [{ name: db, image: "nginx:alpine", ports: [{ containerPort: 80 }] }] }
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata: { name: deny-all, namespace: network-demo }
spec: { podSelector: {}, policyTypes: [Ingress, Egress] }
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata: { name: allow-frontend-to-backend, namespace: network-demo }
spec:
  podSelector: { matchLabels: { role: backend } }
  policyTypes: [Ingress]
  ingress: [{ from: [{ podSelector: { matchLabels: { role: frontend } } }], ports: [{ port: 80 }] }]
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata: { name: allow-backend-to-db, namespace: network-demo }
spec:
  podSelector: { matchLabels: { role: db } }
  policyTypes: [Ingress]
  ingress: [{ from: [{ podSelector: { matchLabels: { role: backend } } }], ports: [{ port: 80 }] }]
M
touch /tmp/.lab-setup-done
