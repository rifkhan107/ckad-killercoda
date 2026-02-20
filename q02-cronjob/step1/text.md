# Task

Create a CronJob named `backup-job` in `default` namespace:

| Field | Value |
|-------|-------|
| Schedule | `*/30 * * * *` |
| Image | `busybox:latest` |
| Command | `echo "Backup completed"` |
| successfulJobsHistoryLimit | `3` |
| failedJobsHistoryLimit | `2` |
| activeDeadlineSeconds | `300` |
| restartPolicy | `Never` |

📖 [CronJobs Docs](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)

---

<details>
<summary>💡 Hint</summary>

`activeDeadlineSeconds` goes under `spec.jobTemplate.spec`, NOT under `spec` directly.

Use `kubectl explain cronjob.spec.jobTemplate.spec` to explore.

</details>

<details>
<summary>📝 Solution</summary>

```bash
kubectl apply -f - <<'YAML'
apiVersion: batch/v1
kind: CronJob
metadata:
  name: backup-job
  namespace: default
spec:
  schedule: "*/30 * * * *"
  successfulJobsHistoryLimit: 3
  failedJobsHistoryLimit: 2
  jobTemplate:
    spec:
      activeDeadlineSeconds: 300
      template:
        spec:
          restartPolicy: Never
          containers:
            - name: backup
              image: busybox:latest
              command: ["/bin/sh", "-c"]
              args: ["echo Backup completed"]
YAML
```

Test immediately:
```bash
kubectl create job backup-test --from=cronjob/backup-job
kubectl logs job/backup-test
```

</details>
