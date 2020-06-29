#!/bin/bash

# teardown docker containers
docker-compose -f docker-compose-CeleryExecutor.yml down

# show no related containers running
docker ps