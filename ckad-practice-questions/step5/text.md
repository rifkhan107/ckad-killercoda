# Q5 – Build Container Image with Podman and Save as Tarball

On the node, directory `/root/app-source` contains a valid Dockerfile.

## Your Task

1. Build a container image using **Podman** (or Docker) with name `my-app:1.0` using `/root/app-source` as build context
2. Save the image as a tarball to `/root/my-app.tar`

> 📝 **Note**: The CKAD exam typically uses Podman, but Docker commands are nearly identical.

## Hints

<details>
<summary>💡 Hint</summary>

```bash
which podman || which docker
podman build -t my-app:1.0 /root/app-source
podman save -o /root/my-app.tar my-app:1.0
```
</details>

## Docs

- [Podman](https://docs.podman.io/)
- [Docker Build](https://docs.docker.com/engine/reference/commandline/build/)
