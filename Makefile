.DEFAULT_GOAL := help

# get a timestamp, for tagging images
timestamp := $(shell date +%s)

# docker run script, for testing images
docker_run := docker run -it --rm \
	--workdir=/src \
	--user=root \
	-v $$(pwd):/src \
	-v $$(pwd)/.gocache:/go/pkg \
	-v $$HOME/.aws:/root/.aws \
	-v $$HOME/.ssh:/root/.ssh \
	$(docker_image)

help: # automatically documents the makefile, by outputing everything behind a ##
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-go-web-server: ## ⚙️  build go-web-server dockerfile
	docker build . -f ./go-web-server/Dockerfile -t lynncyrin/go-web-server:$(timestamp)

shell-go-web-server: ## 🦞 Start a docker shell for go-web-server
	$(MAKE) build-go-web-server
	$(docker_run) lynncyrin/go-web-server:$(timestamp)

ship-go-web-server: ## 🚀 ship go-web-server dockerfile to docker hub
	$(MAKE) build-go-web-server
	docker push lynncyrin/go-web-server:$(timestamp)
