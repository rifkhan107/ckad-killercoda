#!/bin/bash

echo ""
echo "  ╔═══════════════════════════════════════════╗"
echo "  ║     CKAD Practice Lab — 16 Questions      ║"
echo "  ╚═══════════════════════════════════════════╝"
echo ""
echo "⏳ Setting up lab environment..."
echo "   This takes ~60 seconds while resources are provisioned."
echo ""

while [ ! -f /tmp/.lab-setup-done ]; do
  sleep 3
done

echo "✅ Lab environment is ready!"
echo ""
echo "📋 Useful aliases set up for you:"
echo "   k  = kubectl"
echo "   kn = kubectl -n"
echo ""
echo "👉 Click 'Next' to start Question 1"
echo ""

# Set up helpful aliases
echo 'alias k=kubectl' >> /root/.bashrc
echo 'alias kn="kubectl -n"' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc
echo 'export do="--dry-run=client -o yaml"' >> /root/.bashrc
source /root/.bashrc
