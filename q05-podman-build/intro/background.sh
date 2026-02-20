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
touch /tmp/.lab-setup-done
