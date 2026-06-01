#!/bin/bash
[ -s /root/my-app-oci.tar ] || { echo "❌ /root/my-app-oci.tar not found or empty"; exit 1; }
tar tf /root/my-app-oci.tar 2>/dev/null | grep -q "oci-layout" || { echo "❌ File is not OCI archive format (missing oci-layout entry — use --format oci-archive with podman)"; exit 1; }
echo "✅ Passed"
