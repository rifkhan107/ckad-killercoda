#!/bin/bash
while ! kubectl cluster-info &>/dev/null; do sleep 2; done

mkdir -p /root/app-source
cat > /root/app-source/Dockerfile << 'DF'
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
DF
cat > /root/app-source/index.html << 'HTML'
<!DOCTYPE html><html><body><h1>CKAD Practice App v1.0</h1></body></html>
HTML

# Pre-build the image so the student only needs to save it
if command -v podman &>/dev/null; then
  podman build -t my-app:1.0 /root/app-source &>/dev/null
elif command -v docker &>/dev/null; then
  docker build -t my-app:1.0 /root/app-source &>/dev/null
fi

touch /tmp/.lab-setup-done
