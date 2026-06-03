DOCKER_IMAGE=dockette/httpdump
DOCKER_TAG?=latest

.PHONY: build
build:
	docker build --pull -t ${DOCKER_IMAGE}:${DOCKER_TAG} .

.PHONY: test
test: docker-build
	docker compose up -d
	@trap 'docker compose down --volumes --remove-orphans' EXIT; \
		for i in $$(seq 1 30); do \
			curl -fsS http://localhost:8000/ > /dev/null && exit 0; \
			sleep 2; \
		done; \
		curl -fsS http://localhost:8000/ > /dev/null

.PHONY: run
run: test-up

.PHONY: docker-build
docker-build: build

.PHONY: docker-push
docker-push:
	docker push ${DOCKER_IMAGE}:${DOCKER_TAG}

.PHONY: test-up
test-up:
	docker compose up

.PHONY: test-in
test-in:
	docker compose exec httpdump bash
