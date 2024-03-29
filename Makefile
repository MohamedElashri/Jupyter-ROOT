IMAGE_NAME := melashri/jupyter-root
IMAGE_VERSION := 1.0

.DEFAULT_GOAL := run

.PHONY: build
build:
	docker build --no-cache -t $(IMAGE_NAME):$(IMAGE_VERSION) -t $(IMAGE_NAME):latest .

.PHONY: multi-build
multi-build:
	docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE_NAME):$(IMAGE_VERSION) -t $(IMAGE_NAME):latest .

.PHONY: run
run: build
	docker run -it -p 8888:8888 --rm $(IMAGE_NAME):$(IMAGE_VERSION)

.PHONY: push
push:
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)
	docker push $(IMAGE_NAME):latest

.PHONY: dev
dev: build
	docker run -it -p 8888:8888 -v $(PWD):/work --rm $(IMAGE_NAME):$(IMAGE_VERSION) bash