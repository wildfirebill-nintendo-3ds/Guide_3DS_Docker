# 3ds.hacks.guide

A complete guide to 3DS (and 2DS) custom firmware, from stock to boot9strap.

# Docker

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed
- [Docker Compose](https://docs.docker.com/compose/install/) (included with Docker Desktop)

### Building and running with Docker

Build the image:
```bash
docker build -t Guide_3DS_Docker .
```

Run the container:
```bash
docker run -p 8080:80 Guide_3DS_Docker
```

The site will be available at http://localhost:8080.

### Using Docker Compose

```bash
docker compose up -d
```

The site will be available at http://localhost:8080. To stop:
```bash
docker compose down
```

### Pulling from GitHub Container Registry

The image is automatically published to GHCR on every push to `master` and on tagged releases.

```bash
docker pull ghcr.io/wildfirebill-nintendo-3ds/guide_3ds_docker:latest
docker run -p 8080:80 ghcr.io/wildfirebill-nintendo-3ds/guide_3ds_docker:latest
```

Available tags:
- `latest` - latest build from master
- `master` - latest build from master
- `v*` - semantic version tags (e.g., `v1.0.0`, `1.0`)
- `<sha>` - specific commit SHA

## Docker Architecture

The Dockerfile uses a multi-stage build:

1. **Build stage** (`node:20-alpine`): Installs dependencies and builds the VitePress site
2. **Serve stage** (`nginx:alpine`): Serves the static files with nginx

This results in a minimal production image (~40MB) that contains only the built static files and nginx.

### Files

| File | Purpose |
|------|---------|
| `Dockerfile` | Multi-stage build definition |
| `nginx.conf` | Nginx configuration with SPA fallback, gzip, and caching |
| `.dockerignore` | Excludes unnecessary files from the build context |
| `docker-compose.yml` | Local development setup |
| `.github/workflows/docker-publish.yml` | CI/CD workflow for GHCR publishing |

## GitHub Actions Workflow

The `docker-publish.yml` workflow automatically:

1. Triggers on pushes to `master`, version tags (`v*`), PRs, and manual dispatch
2. Builds the Docker image using Buildx with layer caching
3. Pushes to GitHub Container Registry (`ghcr.io`) on non-PR events
4. Tags images with branch name, semver, SHA, and `latest`

### Required Permissions

The workflow uses the default `GITHUB_TOKEN` with `packages: write` permission to push to GHCR. No additional secrets are required.

## Translating

To help translate dsi.cfw.guide, please contribute to its [Crowdin project](https://crowdin.com/project/dsi-guide) ([In-Context](https://dsi.cfw.guide/translate/)), do not PR changes directly to the repository as that will conflict with the translations managed by Crowdin.


# oridginal 3ds.hacks.guide


https://3ds.hacks.guide/

## Running the site locally with Docker

http://localhost:8080

Use docker-compose.yml

## Running the site locally

This requires the following installed on your system:
- node.js

To test the website locally, clone the source code:

```sh
git clone https://github.com/hacks-guide/Guide_3DS --recurse-submodules
cd Guide_3DS
```

Then simply run the following commands:

```sh
npm ci
npm run docs:dev
```

The website should now be running on http://127.0.0.1:5173/ (or a port shown on the terminal).
