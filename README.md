<h1 align=center>Dockette / HTTPDump</h1>

<p align=center>
   Inspect HTTP requests using <a href="https://github.com/beyondcode/httpdump">httpdump</a> app.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
    <a href="https://hub.docker.com/r/dockette/httpdump/"><img src="https://img.shields.io/docker/stars/dockette/httpdump.svg?style=flat-square"></a>
    <a href="https://hub.docker.com/r/dockette/httpdump/"><img src="https://img.shields.io/docker/pulls/dockette/httpdump.svg?style=flat-square"></a>
    <a href="https://bit.ly/ctteg"><img src="https://img.shields.io/gitter/room/contributte/contributte.svg?style=flat-square"></a>
    <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-me-brightgreen?style=flat-square"></a>
</p>

-----

Inspect HTTP requests using the [httpdump](https://github.com/beyondcode/httpdump) app, served by Caddy and PHP-FPM.

## Features

- httpdump from `beyondcode/httpdump` (`master` at build time) on `debian:trixie-slim`
- Caddy and PHP `7.4` (PHP-FPM) with Redis support
- Listens on port `8000`
- `linux/amd64` and `linux/arm64`

## Usage

```yml
version: "3.7"

services:
    httpdump:
        image: dockette/httpdump
        ports:
            - 8000:8000
        environment:
            - APP_ENV=local
            - REDIS_HOST=redis
        volumes:
            # Persistence
            # - .docker/storage:/srv/storage

    redis:
        image: redis:7-alpine
        ports:
            - 6379:6379
```

## Configuration

Set these environment variables. The values below are the defaults.

```sh
APP_NAME=Dockette
APP_ENV=local
APP_KEY=base64:sjJo32LB/+B35zImJQNU2idyWUFoZL1KMmo5pPoiGvU=
APP_DEBUG=true
APP_URL=http://localhost
```

## Versions

| Version | Release |
|---------|---------|
| `dockette/httpdump:YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/httpdump:latest` | latest build of `master` |

Releases are listed on [GitHub](https://github.com/dockette/httpdump/releases).

## Development

```sh
make docker-build   # build the image
make docker-push    # push the image
make test-up        # start httpdump and Redis with docker-compose
make test-in        # open a shell in the httpdump container
make version        # print VERSION
make release        # set today's date in VERSION
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to
[support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
