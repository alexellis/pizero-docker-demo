#!/bin/bash

export DOCKER_HOST=tcp://192.168.0.100:2376

docker rm -f iot1 iot2 iot3

echo "starting nodes"
docker run --privileged -p 5000:5000 -d --label iotnode --name iot1 alexellis2/dockercon-iotnode:latest
docker run --privileged -p 5000:5000 -d --label iotnode --name iot2 alexellis2/dockercon-iotnode:latest
docker run --privileged -p 5000:5000 -d --label iotnode --name iot3 alexellis2/dockercon-iotnode:latest

DOCKER_HOST=""
docker rm -f iotbalancer
docker run --name iotbalancer -e SWARM_URI=192.168.0.100:2376 -e LABEL_FILTER=iotnode -d -p 80:80 alexellis2/nginx_dynamic:v6

