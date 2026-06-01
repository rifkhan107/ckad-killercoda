#!/bin/bash
# Check image exists
if command -v podman &>/dev/null; then
  podman images | grep -q "my-app.*1.0" || { echo "❌ Image my-app:1.0 not found (podman)"; exit 1; }
elif command -v docker &>/dev/null; then
  docker images | grep -q "my-app.*1.0" || { echo "❌ Image my-app:1.0 not found (docker)"; exit 1; }
fi

# Check Docker-format tarball
[ -s /root/my-app.tar ] || { echo "❌ /root/my-app.tar not found or empty"; exit 1; }

# Check OCI archive exists and is valid OCI format
[ -s /root/my-app-oci.tar ] || { echo "❌ /root/my-app-oci.tar not found or empty"; exit 1; }
tar tf /root/my-app-oci.tar 2>/dev/null | grep -q "oci-layout" || {
  echo "❌ /root/my-app-oci.tar is not OCI archive format (missing oci-layout — use: podman save --format oci-archive)"
  exit 1
}

echo "✅ Passed"
