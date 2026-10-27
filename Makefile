.DEFAULT_GOAL := help
.PHONY: help up down stop start restart logs status ps pull config doctor backup

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  make %-12s %s\n", $$1, $$2}'

up: ## Start SonarQube and PostgreSQL in the background
	@test -f .env || (echo "Missing .env. Run: cp .env.example .env, then edit it."; exit 1)
	docker compose up -d

down: ## Stop and remove containers (keeps named volumes/data)
	docker compose down

stop: ## Stop containers without removing them
	docker compose stop

start: ## Start existing containers
	docker compose start

restart: ## Restart services
	docker compose restart

logs: ## Follow SonarQube logs
	docker compose logs -f --tail=150 sonarqube

status: ps ## Alias for ps

ps: ## Show service/container status
	docker compose ps

pull: ## Pull configured container images
	docker compose pull

config: ## Validate and print resolved Compose configuration (secrets are masked)
	@docker compose config --quiet && echo "Compose configuration is valid."

doctor: ## Check local prerequisites and configuration
	@command -v docker >/dev/null || (echo "ERROR: docker is not installed."; exit 1)
	@docker compose version >/dev/null || (echo "ERROR: Docker Compose plugin is unavailable."; exit 1)
	@docker info >/dev/null 2>&1 || (echo "ERROR: Docker daemon is not running or current user lacks permission."; exit 1)
	@test -f .env || (echo "ERROR: .env is missing. Run: cp .env.example .env"; exit 1)
	@docker compose config --quiet || (echo "ERROR: Compose configuration is invalid; check .env."; exit 1)
	@echo "Checks passed. Open http://localhost:$$(grep '^SONAR_PORT=' .env | cut -d= -f2 | tail -n1) after startup completes."

backup: ## Write a PostgreSQL SQL backup under backups/
	@test -f .env || (echo "Missing .env."; exit 1)
	@mkdir -p backups
	@file="backups/sonarqube-db-$$(date +%Y%m%d-%H%M%S).sql"; \
	  docker compose exec -T db sh -c 'pg_dump -U "$$POSTGRES_USER" "$$POSTGRES_DB"' > "$$file" && \
	  echo "Database backup written to $$file"
