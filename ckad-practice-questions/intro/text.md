# CKAD Practice Questions

Welcome to the **Certified Kubernetes Application Developer (CKAD)** practice lab!

This scenario contains **16 hands-on questions** covering core CKAD exam topics:

| Domain | Questions |
|--------|-----------|
| Application Design & Build | Q5 (Podman), Q6 (Canary) |
| Application Deployment | Q8, Q9 (Rolling Update) |
| Application Observability | Q10 (Probes) |
| Application Environment, Configuration & Security | Q1 (Secrets), Q3-Q4 (RBAC), Q7 (NetworkPolicy), Q11 (SecurityContext) |
| Services & Networking | Q12-Q15 (Services, Ingress) |

## How It Works

- **Left panel**: Question instructions
- **Right panel**: Terminal (your workspace)
- Each step has **auto-verification** — click "Check" to validate your work
- Resources are pre-provisioned in the background

## Exam Tips

- Use `kubectl explain <resource>.<field>` to explore API fields
- Bookmark the [Kubernetes Docs](https://kubernetes.io/docs/) — allowed during the exam
- Use `kubectl --dry-run=client -o yaml` to generate YAML quickly
- Practice time management — flag hard questions and move on

> ⏱️ **Challenge yourself**: Try completing all 16 questions within **120 minutes**

The environment is setting up in the background. Wait for the setup to complete before proceeding.
