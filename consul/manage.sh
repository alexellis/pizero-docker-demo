#!/bin/bash

# This script is designed to be run on a 'regular' x64 machine
# rather than a Raspberry PI itself.

export primary_node=100
export manage_port=2376
export swarm_ip=192.168.0.$primary_node
export consul_addr=192.168.0.$primary_node:8500

export container=manage_armv6
export image_name=alexellis2/swarm-arm:v6

echo "Removing old $container container"
docker rm -f $container

echo "Starting new $container container"

echo "Using version: $swarm_version"
export image=swarm

docker run -d -p 2376:2375 --name $container $image_name manage \
consul://$consul_addr/swarm
