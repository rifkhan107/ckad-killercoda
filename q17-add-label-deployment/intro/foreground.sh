#!/bin/bash
echo ""; echo "⏳ Setting up lab environment..."
while [ ! -f /tmp/.lab-setup-done ]; do sleep 2; done
echo "✅ Lab ready!"; echo ""
echo 'alias k=kubectl' >> /root/.bashrc
echo 'alias kn="kubectl -n"' >> /root/.bashrc
echo 'export do="--dry-run=client -o yaml"' >> /root/.bashrc
source /root/.bashrc 2>/dev/null || true
