#!/bin/bash

# teardown docker containers
docker-compose -f docker-compose-CeleryExecutor.yml down

# show running docker compose containers
docker-compose -f docker-compose-CeleryExecutor.yml ps

# remove k3s cluster
k3d delete