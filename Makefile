# Define make entry and help functionality
.DEFAULT_GOAL := help

.PHONY: help

REPO_NAME := mbeacom/cdkata
SHA1 := $$(git log -1 --pretty=%h)
CURRENT_BRANCH := $$(git symbolic-ref -q --short HEAD)
LATEST_TAG := ${REPO_NAME}:latest
GIT_TAG := ${REPO_NAME}:${SHA1}
VERSION := 0.0.0

info: ## Show information about the current git state.
	@echo "Github Project: ${REPO_NAME}\nRepo Location: https://github.com/${REPO_NAME}\nCurrent Branch: ${CURRENT_BRANCH}\nSHA1: ${SHA1}\n"

lint: isort ## Lint this project with Black.
	@poetry run black .

build: ## Build the docker image.
	@docker build -t ${LATEST_TAG} -t ${REPO_NAME}:${SHA1} .

init: ## Initialize the project.
	@poetry install

isort: ## Run isort against the project.
	@poetry run isort --profile black .

action-prep: ## Prepare for poetry action.
	@python -m pip install --upgrade pip
	@curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py
	@python get-poetry.py --preview -y
	@source $HOME/.poetry/env

update-fork: ## Update the current fork master branch with upstream master.
	@echo "Updating the current fork with the upstream master branch..."
	@git checkout master
	@git fetch upstream
	@git merge upstream/master
	@git push origin master
	@echo "Updated!"

update: ## Update the package dependencies via poetry.
	@poetry update

install: ## Install the local development version of the module.
	@poetry install

help: ## Show this help information.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[33m%-25s\033[0m %s\n", $$1, $$2}'
