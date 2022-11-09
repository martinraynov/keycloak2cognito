##
## Help
##

.PHONY: help
help: ## Prints this help message
	@grep -E '^[a-zA-Z_-]+:.*## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

##
## Actions commands
##

export_users: ## Shows the command to use for the export in the Keycloak Server
	$(info $(M) Command : bin/standalone.sh -Djboss.socket.binding.port-offset=1000 -Dkeycloak.migration.action=export -Dkeycloak.migration.provider=dir -Dkeycloak.migration.dir=<EXPORT_FOLDER> -Dkeycloak.migration.realmName=<REALM> -c standalone.xml -P <PATH TO PROPERTIES FILE>)
	$(info $(M) ---)
	$(info $(M) - <EXPORT_FOLDER> : Export destination folder)
	$(info $(M) - <REALM> : Realm to export)
	$(info $(M) - <PATH TO PROPERTIES FILE> : This file isn't mandatory but if you have one for the init of the service you must ise it)

build: ## Build docker image
	_UID=$(id -u) _GID=$(id -g) docker-compose build

migrate: ## Migrate users
	_UID=$(id -u) _GID=$(id -g) docker-compose run --rm migration

dev: ## Access container in sh
	_UID=$(id -u) _GID=$(id -g) docker-compose run --rm migration sh
	_UID=$(id -u) _GID=$(id -g) docker-compose down
