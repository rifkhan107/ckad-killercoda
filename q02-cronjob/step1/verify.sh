#!/bin/bash
kubectl get cronjob backup-job &>/dev/null || { echo "❌ CronJob 'backup-job' not found"; exit 1; }
[ "$(kubectl get cj backup-job -o jsonpath='{.spec.schedule}')" = "*/30 * * * *" ] || { echo "❌ Wrong schedule"; exit 1; }
[ "$(kubectl get cj backup-job -o jsonpath='{.spec.successfulJobsHistoryLimit}')" = "3" ] || { echo "❌ successfulJobsHistoryLimit != 3"; exit 1; }
[ "$(kubectl get cj backup-job -o jsonpath='{.spec.failedJobsHistoryLimit}')" = "2" ] || { echo "❌ failedJobsHistoryLimit != 2"; exit 1; }
[ "$(kubectl get cj backup-job -o jsonpath='{.spec.jobTemplate.spec.activeDeadlineSeconds}')" = "300" ] || { echo "❌ activeDeadlineSeconds != 300"; exit 1; }
[ "$(kubectl get cj backup-job -o jsonpath='{.spec.jobTemplate.spec.template.spec.restartPolicy}')" = "Never" ] || { echo "❌ restartPolicy != Never"; exit 1; }
kubectl get cj backup-job -o jsonpath='{.spec.jobTemplate.spec.template.spec.containers[0].image}' | grep -q busybox || { echo "❌ Wrong image"; exit 1; }
echo "✅ Passed"
