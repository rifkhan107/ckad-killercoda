#!/bin/bash
if command -v podman &>/dev/null; then
  podman images | grep -q "my-app.*1.0" || { echo "❌ Image 'my-app:1.0' not found (podman)"; exit 1; }
elif command -v docker &>/dev/null; then
  docker images | grep -q "my-app.*1.0" || { echo "❌ Image 'my-app:1.0' not found (docker)"; exit 1; }
fi
[ -s /root/my-app.tar ] || { echo "❌ /root/my-app.tar not found or empty"; exit 1; }
echo "✅ Q5 Passed: Image built and saved as tarball"
