# Q2 – Create CronJob with Schedule and History Limits

Create a CronJob named `backup-job` in namespace `default` with the following specifications:

## Requirements

- **Schedule**: Run every 30 minutes (`*/30 * * * *`)
- **Image**: `busybox:latest`
- **Container command**: `echo "Backup completed"`
- **successfulJobsHistoryLimit**: `3`
- **failedJobsHistoryLimit**: `2`
- **activeDeadlineSeconds**: `300`
- **restartPolicy**: `Never`

## Hints

<details>
<summary>💡 Hint 1</summary>

Use `kubectl explain cronjob.spec` to find the correct field names and their hierarchy.
</details>

<details>
<summary>💡 Hint 2</summary>

`activeDeadlineSeconds` goes under `spec.jobTemplate.spec`, NOT under `spec` directly.
</details>

## Docs

- [CronJobs](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
