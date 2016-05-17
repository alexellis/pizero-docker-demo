#!/bin/bash

docker rm -f redis_1 redis_2 redis_3 web_1 web_2 web_3

echo "Redis 1 + 2"

docker run -p 6379:6379 -d --name redis_1 alexellis2/redis-arm:v6
docker run -p 6379:6379 -d --name redis_2 alexellis2/redis-arm:v6
docker run -p 6379:6379 -d --name redis_3 alexellis2/redis-arm:v6

echo "webnode 1 + 2"
docker run -P -d --label webnode --name web_1 --link redis_1:redis alexellis2/pizero-redis-webnode
docker run -P -d --label webnode --name web_2 --link redis_2:redis alexellis2/pizero-redis-webnode
docker run -P -d --label webnode --name web_3 --link redis_3:redis alexellis2/pizero-redis-webnode

DOCKER_HOST=""

docker run -e SWARM_URI=192.168.0.100:2376 -e LABEL_FILTER=webnode -d -p 80:80 alexellis2/nginx_dynamic:v6

