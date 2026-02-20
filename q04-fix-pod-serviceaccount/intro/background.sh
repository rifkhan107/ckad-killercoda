#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
kubectl create ns monitoring
for sa in monitor-sa wrong-sa admin-sa; do kubectl create sa "$sa" -n monitoring; done
kubectl apply -f - <<'M'
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata: { name: metrics-reader, namespace: monitoring }
rules:
  - apiGroups: [""]
    resources: ["pods", "pods/log"]
    verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata: { name: full-access, namespace: monitoring }
rules:
  - apiGroups: ["*"]
    resources: ["*"]
    verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata: { name: view-only, namespace: monitoring }
rules:
  - apiGroups: [""]
    resources: ["services"]
    verbs: ["get", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata: { name: monitor-binding, namespace: monitoring }
roleRef: { apiGroup: rbac.authorization.k8s.io, kind: Role, name: metrics-reader }
subjects:
  - kind: ServiceAccount
    name: monitor-sa
    namespace: monitoring
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata: { name: admin-binding, namespace: monitoring }
roleRef: { apiGroup: rbac.authorization.k8s.io, kind: Role, name: full-access }
subjects:
  - kind: ServiceAccount
    name: admin-sa
    namespace: monitoring
---
apiVersion: v1
kind: Pod
metadata: { name: metrics-pod, namespace: monitoring }
spec:
  serviceAccountName: wrong-sa
  containers:
    - name: metrics
      image: bitnami/kubectl:latest
      command: ["sh", "-c", "while true; do kubectl get pods -n monitoring 2>&1; sleep 10; done"]
M
touch /tmp/.lab-setup-done
