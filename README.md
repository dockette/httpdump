<h1 align=center>Dockette / HTTPDump</h1>

<p align=center>
   <a href="https://github.com/dockette/httpdump/actions"><img src="https://github.com/dockette/httpdump/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/httpdump"><img src="https://img.shields.io/docker/pulls/dockette/httpdump.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   Inspect HTTP requests using <a href="https://github.com/beyondcode/httpdump">httpdump</a> app.
</p>

-----

## Usage

```
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

## Documentation

You can easily setup HTTPDump via environment variables. This is list of default values.

```
- APP_NAME=Dockette
- APP_ENV=local
- APP_KEY=base64:sjJo32LB/+B35zImJQNU2idyWUFoZL1KMmo5pPoiGvU=
- APP_DEBUG=true
- APP_URL=http://localhost
```

## Development

```sh
make build
make test
make run
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
