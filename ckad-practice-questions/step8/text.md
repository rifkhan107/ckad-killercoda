# Q8 – Fix Broken Deployment YAML

File `/root/broken-deploy.yaml` contains a Deployment manifest that **fails to apply**.

## Known Issues

1. Uses **deprecated** API version (`extensions/v1beta1`)
2. **Missing** required `selector` field
3. Selector doesn't match template labels

## Your Task

1. Fix the YAML to use `apiVersion: apps/v1`
2. Add a proper `selector` field matching the template labels
3. Apply the fixed manifest: `kubectl apply -f /root/broken-deploy.yaml`
4. Ensure the Deployment is running

## Docs

- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
