all: help

## ==========================
## Symfony Application
## ==========================
##
## @author Joan López <joanjan14@gmail.com>
## @description Symfony 4 application
##
## Available commands are:
##

IMAGE_TAG=alpine-php

ACCEPTANCE_CONTAINER=api-for-testing
ACCEPTANCE_PORT=8888

##  help:		Help
.PHONE : help
help : Makefile
	@sed -n 's/^##//p' $<

##  build:	Build the Docker image
.PHONY : build
build:
	docker build . -t ${IMAGE_TAG}

##  install:	Install the dependencies with Docker
.PHONY : install
install:
	docker run -it --rm -v ${PWD}:/app alpine-php composer install

##  test:   Run the unit tests
.PHONY : test
test:
	docker run -it --rm -v ${PWD}:/app alpine-php php bin/phpunit

##  acceptance:   Run the acceptance tests
.PHONY : acceptance
acceptance:
	docker run -itd --rm -v ${PWD}:/app --name ${ACCEPTANCE_CONTAINER} alpine-php php bin/console server:run 0.0.0.0:8888
	@-docker run -it --rm -v ${PWD}:/app --link ${ACCEPTANCE_CONTAINER}:api alpine-php vendor/bin/behat
	docker stop ${ACCEPTANCE_CONTAINER}

##  run:		Run a console command
.PHONY : run
run:
	docker run -it --rm -v ${PWD}:/app alpine-php php bin/console $(filter-out $@,$(MAKECMDGOALS))

##  deploy:	Deploy dev server
.PHONY : deploy
deploy:
	docker run -itd --rm -v ${PWD}:/app -p 8000:8000 alpine-php php bin/console server:run 0.0.0.0:8000

## ==========================
## ==========================
