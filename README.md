# CKAD Practice Lab — Killercoda Scenarios

**17 independent scenarios** you can pick in any order, each with:
- 📝 Question panel (left side)
- 💻 Terminal (right side)  
- ✅ Auto-verification (click "Check")
- 📖 Solution step (click "Next" to reveal)

Based on [aravind4799/CKAD-Practice-Questions](https://github.com/aravind4799/CKAD-Practice-Questions)

## Scenarios

| # | Scenario | Topic |
|---|----------|-------|
| 1 | `q01-secret-from-hardcoded-vars` | Secrets & env vars |
| 2 | `q02-cronjob` | CronJob scheduling |
| 3 | `q03-rbac-from-logs` | ServiceAccount, Role, RoleBinding |
| 4 | `q04-fix-pod-serviceaccount` | RBAC troubleshooting |
| 5 | `q05-podman-build` | Container image build |
| 6 | `q06-canary-deployment` | Canary traffic split |
| 7 | `q07-fix-networkpolicy-labels` | NetworkPolicy labels |
| 8 | `q08-fix-broken-deployment` | Fix deprecated API (extensions/v1beta1 → apps/v1) |
| 9 | `q09-rolling-update-rollback` | Rolling update & rollback |
| 10 | `q10-readiness-probe` | Readiness probes |
| 11 | `q11-security-context` | Security context |
| 12 | `q12-fix-service-selector` | Service selector fix |
| 13 | `q13-nodeport-service` | NodePort service |
| 14 | `q14-create-ingress` | Ingress resource |
| 15 | `q15-fix-ingress-pathtype` | Ingress pathType fix |
| 16 | `q16-resource-requests-limits` | ResourceQuota & limits |
| 17 | `q17-add-label-deployment` | Add label to Deployment pod template |

## Setup on Killercoda Creator

### 1. Push to GitHub

```bash
git init
git add .
git commit -m "CKAD practice scenarios"
git branch -M main
git remote add origin git@github.com:rifkhan107/ckad-killercoda.git
git push -u origin main --force
```

### 2. Configure Killercoda Creator

1. **Repo Name**: `ckad-killercoda` | **Branch**: `main`
2. Add **Deploy Key** → GitHub repo → Settings → Deploy Keys
3. Add **Webhook** → GitHub repo → Settings → Webhooks
   - Content type: `application/json`
   - Paste the secret from Killercoda

### 3. Access

Each scenario appears as a separate item at:
```
https://killercoda.com/rifkhan107/course/q01-secret-from-hardcoded-vars
https://killercoda.com/rifkhan107/course/q02-cronjob
...etc
```

Users see all 16 scenarios listed on your profile and can pick any one.

## Structure

```
q01-secret-from-hardcoded-vars/
├── index.json           # Scenario config
├── intro/
│   ├── background.sh    # Provisions resources (runs hidden)
│   ├── foreground.sh    # Shows setup progress
│   └── text.md          # Intro page
├── step1/
│   ├── text.md          # Question
│   └── verify.sh        # Auto-check script
├── step2/
│   └── text.md          # Solution (revealed on "Next")
└── finish/
    └── text.md          # Completion page
```
