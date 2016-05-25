#!/bin/bash

export DOCKER_HOST=tcp://192.168.0.100:2376

docker ps --filter="label=iotnode" -q|xargs docker rm -f

echo "Starting iotnodes"
for i in {1..4};
do
  echo "$i"
  docker run -d --name iotnode_$i --label=iotnode --privileged -P -e affinity:container!=~iotnode_* alexellis2/dockercon-iotnode
done

DOCKER_HOST=""
docker-compose down
docker-compose up -d
