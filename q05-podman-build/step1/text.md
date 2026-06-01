# Task

Directory `/root/app-source` contains a valid Dockerfile.

## Your Task

1. Build a container image named `my-app:1.0` using `/root/app-source` as context
2. Save the image as a tarball to `/root/my-app.tar`

```bash
ls /root/app-source/
cat /root/app-source/Dockerfile
which podman || which docker
```

📖 [Podman Docs](https://docs.podman.io/) | [Docker Build](https://docs.docker.com/engine/reference/commandline/build/)

---

<details>
<summary>💡 Hint</summary>

```bash
docker build -t my-app:1.0 /root/app-source
docker save -o /root/my-app.tar my-app:1.0
```

Replace `docker` with `podman` if that's what's available.

**Exam tip — OCI archive format:**  
The CKAD exam may ask you to save in OCI archive format instead of the default Docker tar.  
Use `podman save --format oci-archive -o /root/my-app.tar my-app:1.0` for that variant.

</details>

<details>
<summary>📝 Solution</summary>

```bash
# Check which tool is available
which podman && CMD=podman || CMD=docker

# Build
$CMD build -t my-app:1.0 /root/app-source

# Save (Docker-format tarball — default)
$CMD save -o /root/my-app.tar my-app:1.0

# Verify
$CMD images | grep my-app
ls -lh /root/my-app.tar
```

**Saving in OCI archive format (if the exam asks for it):**
```bash
podman save --format oci-archive -o /root/my-app.tar my-app:1.0
```

</details>
