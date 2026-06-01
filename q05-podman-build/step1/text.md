# Task

Directory `/root/app-source` contains a valid Dockerfile.

## Your Task

1. Build a container image named `my-app:1.0` using `/root/app-source` as context
2. Save the image as a **Docker-format tarball** to `/root/my-app.tar`
3. Save the image as an **OCI archive** to `/root/my-app-oci.tar`

```bash
ls /root/app-source/
cat /root/app-source/Dockerfile
which podman || which docker
```

> **Why two formats?**  
> `docker save` / `podman save` defaults to Docker format. The CKAD exam also tests `--format oci-archive` (the open OCI standard). They are **not** interchangeable.

📖 [Podman save](https://docs.podman.io/en/latest/markdown/podman-save.1.html) | [Docker Build](https://docs.docker.com/engine/reference/commandline/build/)

---

<details>
<summary>💡 Hint</summary>

```bash
# Build
podman build -t my-app:1.0 /root/app-source

# Docker-format tarball (default)
podman save -o /root/my-app.tar my-app:1.0

# OCI archive format
podman save --format oci-archive -o /root/my-app-oci.tar my-app:1.0
```

Replace `podman` with `docker` if that's what's available.  
Note: `docker save` does **not** support `--format oci-archive` — use `podman` for that.

</details>

<details>
<summary>📝 Solution</summary>

```bash
# Check which tool is available
which podman && CMD=podman || CMD=docker

# Build
$CMD build -t my-app:1.0 /root/app-source

# Save as Docker-format tarball
$CMD save -o /root/my-app.tar my-app:1.0

# Save as OCI archive (podman only)
podman save --format oci-archive -o /root/my-app-oci.tar my-app:1.0

# Verify both files
ls -lh /root/my-app.tar /root/my-app-oci.tar
tar tf /root/my-app-oci.tar | grep oci-layout
```

**What's inside an OCI archive (vs Docker tar):**

| File | Docker tar | OCI archive |
|------|-----------|-------------|
| `manifest.json` | ✅ | ❌ |
| `oci-layout` | ❌ | ✅ |
| `index.json` | ❌ | ✅ |
| `blobs/sha256/` | ❌ | ✅ |

</details>
