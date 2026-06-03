# AGENTS.md

## Project

Dockette HTTPDump packages the Beyond Code HTTPDump Laravel application as a Docker image for inspecting HTTP requests behind Caddy and PHP-FPM.

## Image And Context

- Docker image: `dockette/httpdump`.
- Default Makefile tag: `latest`.
- Single build context: repository root `.`.
- Base image: `dockette/debian:bullseye-slim`.
- Runtime stack: Caddy, PHP 7.4 FPM, Composer-installed `beyondcode/httpdump`, and optional Redis from compose.

## Commands

- `make build` builds `${DOCKER_IMAGE}:${DOCKER_TAG}` with `docker build --pull`.
- `make test` builds the image through `docker-build`, starts compose in the background, and polls `http://localhost:8000/`.
- `make run` starts `docker compose up` through `test-up`.
- `make test-in` opens a shell in the running `httpdump` service.
- `make docker-push` pushes the selected tag and should only be used when explicitly requested.

## Compose And Runtime Notes

- `docker-compose.yml` starts `httpdump` on host port `8000` and a `redis:7-alpine` service on host port `6379`.
- Compose mounts `.docker/storage` to `/srv/storage` for persistence.
- The image copies repository `.env` into `/srv/.env`; avoid committing real secrets there.
- `entrypoint.sh` prepares Laravel storage directories, starts `php-fpm7.4` in the foreground, starts Caddy with `/etc/Caddyfile`, and waits for either process to exit.
- `Caddyfile` serves `/srv/public`, hides `.git`, enables gzip and logging, disables the admin API, and proxies PHP through `/var/run/php-fpm.sock`.

## Guidelines

- Keep Dockerfile package versions, `php.ini`, `php-fpm.conf`, `Caddyfile`, compose ports, README examples, and workflow commands aligned.
- Prefer `DOCKER_*` names for Docker-related Makefile variables.
- Place `.PHONY: <target>` directly above each Makefile target.
- Do not change exposed ports, storage paths, or Laravel environment defaults without updating tests and documentation.
- Do not introduce unrelated formatting or structural changes.
