# memoh-builds

Build and publish fresh multi-arch Memoh images from `memohai/Memoh` `main` to GHCR.

Published images:

- `ghcr.io/Lakr233/memoh-server`
- `ghcr.io/Lakr233/memoh-web`
- `ghcr.io/Lakr233/memoh-browser`
- `ghcr.io/Lakr233/memoh-sparse`

What this repo does:

- Polls upstream `memohai/Memoh` `main` every 15 minutes
- Skips work if the current upstream commit was already built
- Builds `linux/amd64` and `linux/arm64`
- Pushes floating `:dev` tags
- Pushes immutable `:sha-<shortsha>` tags
- Collects exact pulled digests as workflow artifacts

Manual trigger:

```bash
gh workflow run build-memoh.yml --repo Lakr233/memoh-builds
```

Example pulls:

```bash
docker pull ghcr.io/Lakr233/memoh-server:dev
docker pull ghcr.io/Lakr233/memoh-server:sha-abcdef1
docker pull ghcr.io/Lakr233/memoh-server@sha256:...
```

Suggested server update flow:

```bash
docker compose pull
docker compose down
docker compose up -d
```
