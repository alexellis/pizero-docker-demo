## DockerCon 2016 Hack

**Live IoT cluster demonstration**

Load-balanced Python flask service with LED lights to show when an upstream server is being utilized. This is designed to be both educational and to serve as an example of what can be done when combining Docker with the Raspberry PI.

* Hardware: Raspberry PI Zero [Find stock here](http://stockalert.alexellis.io/)
* Software: Arch Linux ARM, Docker, Swarm, [pre-built ARM images](https://github.com/alexellis/docker-arm/tree/master/images/armv6).

*Honoured to have had this [retweeted by Solomon Hykes](https://twitter.com/alexellisuk/status/732497170234937344), the creator of Docker*

### Demo on Instagram:

![Screenshot from Instagram](https://raw.githubusercontent.com/alexellis/pizero-docker-demo/master/static/cluster-mid-flow.png)

Check out the demos:

* Demo #1

I talk you through hitting the load balancer with 1, 2, 3 and 6 concurrent requests to show how the lights respond.

https://www.instagram.com/p/BFgErp6AvOE/

* Demo #2

I start with load from Apache Bench then in the second half hit the load balancer manually through curl.
https://www.instagram.com/p/BFgARoFgvIQ/

### Step 1

Start the Swarm manager

```
$ git clone https://github.com/alexellis/pizero-docker-demo.git
$ cd pizero-docker-demo
$ cd consul
$ ./start_consul.sh
$ ./manage.sh
```

### Step 2 Start Swarm agents

Perform this step on each Raspberry PI. It must have Arch Linux ARM (ALARM) installed and Docker before going any further.

> [Install Arch Linux ARM and Docker](http://blog.alexellis.io/dockerswarm-pizero/)

```
$ git clone https://github.com/alexellis/pizero-docker-demo.git
$ cd pizero-docker-demo
$ cd join
$ ./auto_join.sh
```

I use a shell script called `run.sh` for this to make running multiple commands easier.

```
#!/bin/sh

hosts=(192.168.0.100
192.168.0.101
192.168.0.102
192.168.0.103
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
```

*run.sh*

### Step 3 Start the IoTNode containers and Nginx

```
$ ./start_lights.sh 
```

Use `curl` to access the Nginx instance or `ab` to add some load such as:

```
ab -c 1 -n 100 http://192.168.0.100/
```

### Feedback or questions?

Send me a tweet at @alexellisuk

