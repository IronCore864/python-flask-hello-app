.PHONY: clean build run stop

IMAGE_NAME = ironcore864/ironcore864/flask-hello
CONTAINER_NAME = flask-demoapp

build:
	docker build -t $(IMAGE_NAME) .

release:
	docker build \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` -t $(IMAGE_NAME) .

run:
	docker run --rm -p 5000:5000 -d --name $(CONTAINER_NAME) $(IMAGE_NAME)

shell:
	docker exec -it $(CONTAINER_NAME) /bin/sh

stop:
	docker stop $(CONTAINER_NAME)

clean:
	docker ps -a | grep '$(CONTAINER_NAME)' | awk '{print $$1}' | xargs docker rm \
	docker images | grep '$(IMAGE_NAME)' | awk '{print $$3}' | xargs docker rmi

