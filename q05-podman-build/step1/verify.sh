#!/bin/bash
# Check image exists in either podman or docker
if command -v podman &>/dev/null; then
  podman images | grep -q "my-app.*1.0" || { echo "❌ Image my-app:1.0 not found (podman)"; exit 1; }
elif command -v docker &>/dev/null; then
  docker images | grep -q "my-app.*1.0" || { echo "❌ Image my-app:1.0 not found (docker)"; exit 1; }
fi

# Check tarball exists (any format — Docker tar or OCI archive both accepted)
[ -s /root/my-app.tar ] || { echo "❌ /root/my-app.tar not found or empty"; exit 1; }

echo "✅ Passed"
