# CKAD Practice Lab – Killercoda Scenario

Interactive CKAD exam practice with **16 auto-verified questions**, split-screen terminal, and step-by-step verification — just like the real exam.

Based on [aravind4799/CKAD-Practice-Questions](https://github.com/aravind4799/CKAD-Practice-Questions).

## 🚀 How to Set Up on Killercoda Creator

### 1. Create a GitHub Repository

Create a new repo (e.g., `ckad-killercoda`) and push the `ckad-practice-questions/` directory to it.

```bash
git init
git add .
git commit -m "Initial CKAD practice scenario"
git branch -M main
git remote add origin git@github.com:<your-username>/ckad-killercoda.git
git push -u origin main
```

### 2. Configure Killercoda Creator

Go to [killercoda.com/creator](https://killercoda.com/creator) and:

1. **Repo Name**: Enter your repo name (e.g., `ckad-killercoda`)
2. **Branch**: `main`
3. **Deploy Key**: Copy the SSH key from Killercoda and add it to your GitHub repo:
   - GitHub repo → Settings → Deploy Keys → Add deploy key
4. **Webhook**: Copy the Webhook URL from Killercoda and add it to your GitHub repo:
   - GitHub repo → Settings → Webhooks → Add webhook
   - Set Content type to `application/json`
   - Paste the Secret from Killercoda

### 3. Push and Test

After setting up the webhook, every push to `main` will auto-sync to Killercoda. Your scenario will be available at:

```
https://killercoda.com/<your-username>/ckad-practice-questions
```

## 📋 Questions Covered

| # | Topic | Namespace |
|---|-------|-----------|
| 1 | Create Secret from Hardcoded Variables | default |
| 2 | Create CronJob with Schedule & History Limits | default |
| 3 | Create ServiceAccount, Role, and RoleBinding | audit |
| 4 | Fix Broken Pod with Correct ServiceAccount | monitoring |
| 5 | Build Container Image & Save as Tarball | n/a |
| 6 | Create Canary Deployment with Traffic Split | default |
| 7 | Fix NetworkPolicy by Updating Pod Labels | network-demo |
| 8 | Fix Broken Deployment YAML | default |
| 9 | Perform Rolling Update and Rollback | default |
| 10 | Add Readiness Probe to Deployment | default |
| 11 | Configure Pod & Container Security Context | default |
| 12 | Fix Service Selector | default |
| 13 | Create NodePort Service | default |
| 14 | Create Ingress Resource | default |
| 15 | Fix Ingress PathType | default |
| 16 | Add Resource Requests and Limits | prod |

## 🏗️ Scenario Structure

```
ckad-practice-questions/
├── index.json              # Scenario config (kubernetes-kubeadm-1node)
├── intro/
│   ├── text.md             # Welcome page
│   ├── background.sh       # Provisions all resources
│   └── foreground.sh       # Displays progress to user
├── step1/ ... step16/
│   ├── text.md             # Question instructions + hints
│   └── verify.sh           # Auto-verification script
└── finish/
    └── text.md             # Completion page
```

## Credits

- Questions: [aravind4799/CKAD-Practice-Questions](https://github.com/aravind4799/CKAD-Practice-Questions)
- Platform: [Killercoda](https://killercoda.com)
