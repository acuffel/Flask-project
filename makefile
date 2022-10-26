# Commands
default: help

.PHONY: venv
venv: ## Creates a virtual environment.
	python3 -m venv venv

.PHONY: install
install: ## Installs production dependencies.
	venv/bin/pip install --upgrade pip wheel setuptools
	venv/bin/pip install -r requirements.txt
	rm -rf ~/.cache/pip

.PHONY: requirements
requirements: ## Builds or updates requirements.
	venv/bin/pip install --upgrade pip wheel setuptools pip-tools
	venv/bin/pip-compile --upgrade requirements.in
	
.PHONY: init_db
init-db: ## Builds or updates requirements.
	venv/bin/flask --app flaskr init-db

.PHONY: run_debug_server
run-debug-server: ## Builds or updates requirements.
	venv/bin/flask --app flaskr --debug run

.PHONY: tests
tests: ## Builds or updates requirements.
	venv/bin/coverage run -m pytest
	venv/bin/coverage report

.PHONY: help
help: ## Lists all the available commands.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
