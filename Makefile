.DEFAULT_GOAL := help

timestamp := $(shell date +%s)

help: # automatically documents the makefile, by outputing everything behind a ##
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-go-web-server: # ## build go-web-server dockerfile
	docker build . -f ./go-web-server/Dockerfile -t lynncyrin/go-web-server:$(timestamp)

ship-go-web-server: ## ship go-web-server dockerfile to docker hub
	$(MAKE) build-go-web-server
	docker push lynncyrin/go-web-server:$(timestamp)
