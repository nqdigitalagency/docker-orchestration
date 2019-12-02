# Docker Orchestration

Enviroments: PHP, MYSQL, NGINX, REDIS

Docker images are public to use on swarm and can be founded in:

https://hub.docker.com/repository/docker/nqda/php
https://hub.docker.com/repository/docker/nqda/mysql
https://hub.docker.com/repository/docker/nqda/nginx

To use it as your local development please use Makefile to run commands.

````
## Remove the .env file for docker
make docker-clean

## List dockers
make docker-ps

## Make sure the .env file exists for docker
make docker-init

## Build all docker images from scratch, without cache etc.
## Build a specific image by providing the service name via: make docker-build CONTAINER=<service>

make docker-build-from-scratch

## Build all docker images. Build a specific image by providing the service name via: make docker-build CONTAINER=<service>
make docker-build

## Remove unused docker resources via 'docker system prune -a -f --volumes'
make docker-prune

## Start all docker containers. To only start one container, use CONTAINER=<service>
make docker-up

## Stop all docker containers. To only stop one container, use CONTAINER=<service>
make docker-down

make docker-stop-all
````

To publish image use like:

````
docker build -t nqda/php -f .docker/php-fpm/Dockerfile .
docker push nqda/php
````

Composer files (stage and production) are configured to be used in docker swarm mode with traefik.