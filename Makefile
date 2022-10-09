# redis-rb

.DEFAULT_GOAL := help

.PHONY: up
up: ## Start redis
	docker-compose up -d

.PHONY: stop
stop: ## Stop redis
	docker-compose stop

.PHONY: down
down: ## Destroy redis
	docker-compose down

.PHONY: ps
ps: ## Show redis container
	docker-compose ps

.PHONY: help
help: ## Show option
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
