DOCKER_RUN = docker compose run --rm app
DOCKER_COMPOSE = docker compose

.PHONY: setup dev build clean lint ui-add ui-init install

# Builda a imagem e instala as libs
setup:
	$(DOCKER_COMPOSE) build
	$(DOCKER_RUN) bun install
	$(DOCKER_RUN) bunx husky install || true
	cp .env.example .env || true

dev:
	$(DOCKER_COMPOSE) up

install:
	$(DOCKER_RUN) bun add $(PKG)

ui-init:
	$(DOCKER_RUN) bunx shadcn@latest init

ui-add:
	$(DOCKER_RUN) bunx shadcn@latest add $(COMPONENT)

lint:
	$(DOCKER_RUN) bunx @biomejs/biome check --write .

clean:
	rm -rf .next node_modules
	$(DOCKER_COMPOSE) down --volumes --remove-orphans