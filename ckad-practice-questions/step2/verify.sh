#!/bin/bash

kubectl get cronjob backup-job -n default &>/dev/null || {
  echo "❌ CronJob 'backup-job' not found"
  exit 1
}

SCHEDULE=$(kubectl get cronjob backup-job -n default -o jsonpath='{.spec.schedule}')
[ "$SCHEDULE" = "*/30 * * * *" ] || {
  echo "❌ Schedule is '$SCHEDULE', expected '*/30 * * * *'"
  exit 1
}

SHL=$(kubectl get cronjob backup-job -n default -o jsonpath='{.spec.successfulJobsHistoryLimit}')
[ "$SHL" = "3" ] || {
  echo "❌ successfulJobsHistoryLimit is '$SHL', expected '3'"
  exit 1
}

FHL=$(kubectl get cronjob backup-job -n default -o jsonpath='{.spec.failedJobsHistoryLimit}')
[ "$FHL" = "2" ] || {
  echo "❌ failedJobsHistoryLimit is '$FHL', expected '2'"
  exit 1
}

ADS=$(kubectl get cronjob backup-job -n default -o jsonpath='{.spec.jobTemplate.spec.activeDeadlineSeconds}')
[ "$ADS" = "300" ] || {
  echo "❌ activeDeadlineSeconds is '$ADS', expected '300'"
  exit 1
}

RP=$(kubectl get cronjob backup-job -n default -o jsonpath='{.spec.jobTemplate.spec.template.spec.restartPolicy}')
[ "$RP" = "Never" ] || {
  echo "❌ restartPolicy is '$RP', expected 'Never'"
  exit 1
}

IMAGE=$(kubectl get cronjob backup-job -n default -o jsonpath='{.spec.jobTemplate.spec.template.spec.containers[0].image}')
echo "$IMAGE" | grep -q "busybox" || {
  echo "❌ Image is '$IMAGE', expected 'busybox:latest'"
  exit 1
}

echo "✅ Q2 Passed: CronJob backup-job configured correctly"
