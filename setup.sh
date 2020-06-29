#!/bin/bash

# build custom docker image
docker build --rm -t puckel/docker-airflow:custom .

# start docker compose
docker-compose -f docker-compose-CeleryExecutor.yml up -d

echo "***********************"
echo "Wait for the docker containers to settle"
echo "***********************"
sleep 15s

# show running containers
docker ps


# show links in terminal
echo "airflow UI webserver --> http://localhost:8080"
echo "flower UI webserver --> http://localhost:5555"