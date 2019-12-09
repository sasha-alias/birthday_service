#!/bin/bash

# script for building and publishing docker images of the birthday service to the dockerhub

docker build -t olsender/birthday_service_backend:latest ./backend/
docker build -t olsender/birthday_service_db:latest ./db/
docker push olsender/birthday_service_backend:latest
docker push olsender/birthday_service_db:latest
