.PHONY: build bundle clean dev first help install .PHONY restart shell start stop test test-watch up tsc-watch

help:		## List all make commands
	@awk 'BEGIN {FS = ":.*##"; printf "\n  Please use `make <target>` where <target> is one of:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) }' $(MAKEFILE_LIST)
	@echo ' '

build:
	docker compose build

bundle:		## Run npm build to bundle final
	docker compose run --rm web rm -rf dist/
	docker compose run --rm web npm run build

clean: stop	## Stop and remove containers and node_modules
	docker compose down -v --remove-orphans
	rm -rf node_modules

dev:
	docker compose run --rm web npm run dev -- --host

tsc-watch:  ## Run typescript type-check in watch mode
	docker compose run --rm web npm run type-check-watch

first: build install start  ## Build the env, up it and run the npm install and then run npm run dev it to

install:	## Run npm install
	docker compose run --rm web npm install

shell:	## Interactive mode in web
	docker compose run --rm web bash

restart: stop start ## Compose Kill, rm and start again

start: up dev

stop:	## Compose kill and rm
	docker compose kill
	docker compose rm --force

test:	## Run tests
	docker compose run --rm web npm run test:unit

test-watch:	## Run tests in watch mode
	docker compose run --rm web npm run test-watch:unit

up:
	docker compose up --build --no-recreate -d

