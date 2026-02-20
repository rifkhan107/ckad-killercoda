#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done
kubectl wait --for=condition=Ready node --all --timeout=120s
touch /tmp/.lab-setup-done
