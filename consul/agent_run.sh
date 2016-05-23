#!/bin/sh

hosts=(192.168.0.101
192.168.0.102
192.168.0.103
192.168.0.104
)

exec_cmd() {
 echo "[$1] $2"
 echo ""
 ssh $1 $2
 echo ""
}

for host in "${hosts[@]}"
do
    exec_cmd $host "$@"
done
