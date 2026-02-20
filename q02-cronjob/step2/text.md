# Solution

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

**Key**: `activeDeadlineSeconds` goes under `jobTemplate.spec`, NOT `spec`.
