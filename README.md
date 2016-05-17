## DockerCon 2016 Hack

**Live IoT cluster demonstration**

Load-balanced Python flask service with LED lights to show when an upstream server is being utilized. This is designed to be both educational and to serve as an example of what can be done when combining Docker with the Raspberry PI.

* Hardware: Raspberry PI Zero [Find stock here](http://stockalert.alexellis.io/)
* Software: Arch Linux ARM, Docker, Swarm, pre-built ARM images.

### Demo on Instagram:

Check out the demo - I start with load from Apache Bench then in the second half hit the load balancer manually through curl.

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

Perform this step on each Raspberry PI. It must have ALARM installed and Docker before going any further.

```
$ git clone https://github.com/alexellis/pizero-docker-demo.git
$ cd pizero-docker-demo
$ cd join
$ ./auto_join.sh
```

### Step 3 Start Nginx

```
$ ./start_lights.sh 
```

Use `curl` to access the Nginx instance or `ab` to add some load such as:

```
ab -c 1 -n 100 http://192.168.0.100/
```


