## DockerCon 2016 Hack

**Live IoT cluster demonstration**

Load-balanced Node.js service with LED lights to show when an upstream server is being utilized.

* Hardware: Raspberry PI Zero
* Software: Arch Linux ARM, Docker, Swarm, pre-built ARM images.

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
$ docker run -e SWARM_URI=192.168.0.100:2376 -e LABEL_FILTER=gpio_count -d -p 80:80 alexellis2/nginx-dynamic:v6
```

Use `curl` to access the Nginx instance.


