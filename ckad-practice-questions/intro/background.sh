#!/bin/bash

# Wait for Kubernetes cluster to be ready
while ! kubectl cluster-info &>/dev/null; do
  sleep 2
done

# Wait for node to be Ready
kubectl wait --for=condition=Ready node --all --timeout=120s

#=============================================================================
# Q1 – Deployment with hardcoded env vars
#=============================================================================
kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-server
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: api-server
  template:
    metadata:
      labels:
        app: api-server
    spec:
      containers:
        - name: api
          image: busybox:latest
          command: ["sh", "-c", "while true; do echo DB_USER=$DB_USER DB_PASS=$DB_PASS; sleep 30; done"]
          env:
            - name: DB_USER
              value: "admin"
            - name: DB_PASS
              value: "Secret123!"
EOF

#=============================================================================
# Q3 – RBAC scenario in audit namespace
#=============================================================================
kubectl create ns audit

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: log-collector
  namespace: audit
spec:
  serviceAccountName: default
  containers:
    - name: collector
      image: bitnami/kubectl:latest
      command:
        - sh
        - -c
        - |
          while true; do
            kubectl get pods -n audit 2>&1 || true
            sleep 10
          done
EOF

#=============================================================================
# Q4 – Broken ServiceAccount in monitoring namespace
#=============================================================================
kubectl create ns monitoring

for sa in monitor-sa wrong-sa admin-sa; do
  kubectl create sa "$sa" -n monitoring
done

kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: metrics-reader
  namespace: monitoring
rules:
  - apiGroups: [""]
    resources: ["pods", "pods/log"]
    verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: full-access
  namespace: monitoring
rules:
  - apiGroups: ["*"]
    resources: ["*"]
    verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: view-only
  namespace: monitoring
rules:
  - apiGroups: [""]
    resources: ["services"]
    verbs: ["get", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: monitor-binding
  namespace: monitoring
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: metrics-reader
subjects:
  - kind: ServiceAccount
    name: monitor-sa
    namespace: monitoring
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: admin-binding
  namespace: monitoring
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: full-access
subjects:
  - kind: ServiceAccount
    name: admin-sa
    namespace: monitoring
EOF

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: metrics-pod
  namespace: monitoring
spec:
  serviceAccountName: wrong-sa
  containers:
    - name: metrics
      image: bitnami/kubectl:latest
      command:
        - sh
        - -c
        - |
          while true; do
            kubectl get pods -n monitoring 2>&1 || true
            sleep 10
          done
EOF

#=============================================================================
# Q5 – Dockerfile for Podman build
#=============================================================================
mkdir -p /root/app-source

cat > /root/app-source/Dockerfile <<'DOCKERFILE'
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
DOCKERFILE

cat > /root/app-source/index.html <<'HTML'
<!DOCTYPE html>
<html><body><h1>CKAD Practice App v1.0</h1></body></html>
HTML

#=============================================================================
# Q6 – Canary deployment setup
#=============================================================================
kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  namespace: default
spec:
  replicas: 5
  selector:
    matchLabels:
      app: webapp
      version: v1
  template:
    metadata:
      labels:
        app: webapp
        version: v1
    spec:
      containers:
        - name: web
          image: nginx:1.24
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: web-service
  namespace: default
spec:
  selector:
    app: webapp
  ports:
    - port: 80
      targetPort: 80
EOF

#=============================================================================
# Q7 – NetworkPolicy with wrong labels
#=============================================================================
kubectl create ns network-demo

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: frontend
  namespace: network-demo
  labels:
    role: wrong-frontend
spec:
  containers:
    - name: frontend
      image: nginx:alpine
      ports:
        - containerPort: 80
---
apiVersion: v1
kind: Pod
metadata:
  name: backend
  namespace: network-demo
  labels:
    role: wrong-backend
spec:
  containers:
    - name: backend
      image: nginx:alpine
      ports:
        - containerPort: 80
---
apiVersion: v1
kind: Pod
metadata:
  name: database
  namespace: network-demo
  labels:
    role: wrong-db
spec:
  containers:
    - name: database
      image: nginx:alpine
      ports:
        - containerPort: 80
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all
  namespace: network-demo
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-to-backend
  namespace: network-demo
spec:
  podSelector:
    matchLabels:
      role: backend
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              role: frontend
      ports:
        - port: 80
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-backend-to-db
  namespace: network-demo
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              role: backend
      ports:
        - port: 80
EOF

#=============================================================================
# Q8 – Broken deployment YAML
#=============================================================================
cat > /root/broken-deploy.yaml <<'EOF'
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
EOF

#=============================================================================
# Q9 – Rolling update deployment
#=============================================================================
kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-v1
  namespace: default
spec:
  replicas: 3
  selector:
    matchLabels:
      app: app-v1
  template:
    metadata:
      labels:
        app: app-v1
    spec:
      containers:
        - name: web
          image: nginx:1.20
          ports:
            - containerPort: 80
EOF

#=============================================================================
# Q10 – Deployment needing readiness probe
#=============================================================================
kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-deploy
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: api-deploy
  template:
    metadata:
      labels:
        app: api-deploy
    spec:
      containers:
        - name: api
          image: nginx:latest
          ports:
            - containerPort: 8080
EOF

#=============================================================================
# Q11 – Deployment needing security context
#=============================================================================
kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: secure-app
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: secure-app
  template:
    metadata:
      labels:
        app: secure-app
    spec:
      containers:
        - name: app
          image: nginx:latest
          ports:
            - containerPort: 80
EOF

#=============================================================================
# Q12 – Service with wrong selector
#=============================================================================
kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deploy
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: webapp
      tier: frontend
  template:
    metadata:
      labels:
        app: webapp
        tier: frontend
    spec:
      containers:
        - name: web
          image: nginx:latest
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: web-svc
  namespace: default
spec:
  selector:
    app: wrongapp
  ports:
    - port: 80
      targetPort: 80
EOF

#=============================================================================
# Q13 – Deployment for NodePort service
#=============================================================================
kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-np-server
  namespace: default
  labels:
    app: api
spec:
  replicas: 2
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
        - name: api
          image: nginx:latest
          ports:
            - containerPort: 9090
EOF

#=============================================================================
# Q15 – Broken ingress YAML
#=============================================================================
cat > /root/fix-ingress.yaml <<'EOF'
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
EOF

#=============================================================================
# Q16 – ResourceQuota in prod namespace
#=============================================================================
kubectl create ns prod

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: ResourceQuota
metadata:
  name: prod-quota
  namespace: prod
spec:
  hard:
    limits.cpu: "2"
    limits.memory: "4Gi"
    requests.cpu: "1"
    requests.memory: "2Gi"
    pods: "5"
EOF

# Wait for key deployments to be ready
kubectl rollout status deploy/api-server -n default --timeout=120s 2>/dev/null || true
kubectl rollout status deploy/web-app -n default --timeout=120s 2>/dev/null || true
kubectl rollout status deploy/app-v1 -n default --timeout=120s 2>/dev/null || true

# Signal that setup is complete
touch /tmp/.lab-setup-done
echo "CKAD Lab Setup Complete" > /tmp/.lab-setup-done
