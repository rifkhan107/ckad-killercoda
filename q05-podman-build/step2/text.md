# Solution

Using Docker (or replace with `podman`):
```bash
cd /root/app-source
docker build -t my-app:1.0 .
docker save -o /root/my-app.tar my-app:1.0
```

Verify:
```bash
docker images | grep my-app
ls -lh /root/my-app.tar
```
