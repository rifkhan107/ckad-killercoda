# Task

Existing resources:
- Deployment `web-app`: 5 replicas, labels `app=webapp, version=v1`
- Service `web-service`: selector `app=webapp`

**Your Task:**
1. Scale `web-app` to **8** replicas
2. Create Deployment `web-app-canary` with **2** replicas, labels `app=webapp, version=v2`
3. Both must be selected by `web-service`

📖 [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
