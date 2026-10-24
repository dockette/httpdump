DOCKER_IMAGE=dockette/httpdump
VERSION:=$(shell cat VERSION)

docker-build:
	docker build --pull -t ${DOCKER_IMAGE} .

docker-push:
	docker push ${DOCKER_IMAGE}

test-up:
	docker-compose up

test-in:
	docker-compose exec httpdump bash

.PHONY: version
version:
	@echo ${VERSION}

.PHONY: release
release:
	@date -u +%Y.%m.%d > VERSION
	@echo "VERSION: ${VERSION} -> $$(cat VERSION)"
	@echo "next: git commit -am \"Release: $$(cat VERSION)\" && git push"
