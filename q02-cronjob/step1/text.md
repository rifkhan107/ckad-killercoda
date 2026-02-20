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

💡 Use `kubectl explain cronjob.spec.jobTemplate.spec` to find where `activeDeadlineSeconds` goes.

📖 [CronJobs Docs](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
