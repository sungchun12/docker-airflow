#!/bin/bash

# pull docker image
docker pull puckel/docker-airflow:1.10.9

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