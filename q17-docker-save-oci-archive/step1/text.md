# Task

Image `my-app:1.0` is already built and available locally.

## Your Task

Save the image `my-app:1.0` to `/root/my-app-oci.tar` using **OCI archive format** (not the default Docker tar format).

```bash
# Confirm the image exists
podman images | grep my-app
```

> **Why OCI format?**  
> The default `docker save` / `podman save` produces a Docker-format tarball.  
> OCI archive format (`--format oci-archive`) is the open standard and what the CKAD exam specifically tests.

📖 [Podman save](https://docs.podman.io/en/latest/markdown/podman-save.1.html) | [OCI Image Spec](https://github.com/opencontainers/image-spec)

---

<details>
<summary>💡 Hint</summary>

With `podman`, pass the `--format` flag:

```bash
podman save --format oci-archive -o /root/my-app-oci.tar my-app:1.0
```

Docker's `docker save` does **not** support OCI archive format — use `podman` or `skopeo`.

</details>

<details>
<summary>📝 Solution</summary>

```bash
# Save in OCI archive format
podman save --format oci-archive -o /root/my-app-oci.tar my-app:1.0

# Verify: file exists and is a valid OCI archive
ls -lh /root/my-app-oci.tar
tar tf /root/my-app-oci.tar | grep oci-layout
```

**What's inside an OCI archive:**
```
oci-layout          ← marker file (must be present)
index.json          ← image index
blobs/sha256/...    ← image layers
```

**Alternative using skopeo:**
```bash
skopeo copy docker-daemon:my-app:1.0 oci-archive:/root/my-app-oci.tar
```

</details>
