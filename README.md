## DockerCon 2016 Hack

**Live IoT cluster demonstration**

Load-balanced Python flask service with LED lights to show when an upstream server is being utilized. This is designed to be both educational and to serve as an example of what can be done when combining Docker with the Raspberry PI.

* Hardware: Raspberry PI Zero [Find stock here](http://stockalert.alexellis.io/)
* Software: Arch Linux ARM, Docker, Swarm, [pre-built ARM images](https://github.com/alexellis/docker-arm/tree/master/images/armv6).

*Honoured to have had this [retweeted by Solomon Hykes](https://twitter.com/alexellisuk/status/732497170234937344), the creator of Docker*

### Technical Deep Dive

View the [technical Deep Dive](http://blog.alexellis.io/iot-docker-cluster/) here on my blog.

### Watch me on Pimoroni's live YouTube TV show

In *Bilge Tank 039 - Clusters, Docker, Brambles & Raspberry Pi Supercomputers!* I talk Docker, what it means to be a Docker Captain and all about Docker Swarm.

[BilgeTank 039 on YouTube](https://www.youtube.com/watch?v=ASYnWV0Km_A)

### Watch the demo

![Click link for video](https://pbs.twimg.com/media/CjDxIg-WEAAQ1dk.jpg)

In the video I give a quick explanation of the setup then use `curl` and Apache Bench `ab` to simulate a real-world load on the cluster.

[View on YouTube](https://www.youtube.com/embed/IaKRqBRq6CE)

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
./consul_/agent_run "cd pizero-docker-demo/join && ./auto_join.sh"
```

[View run.sh](https://github.com/alexellis/pizero-docker-demo/blob/master/consul/run.sh)

To enable all the clustering features we have to specify a KVP store for each of our agents. This will be the consul instance we started on the manager.

Edit `/usr/lib/systemd/system/docker.service` and update the ExecStart line:

```
ExecStart=/usr/bin/docker daemon -H fd:// -H tcp://0.0.0.0:2375 --cluster-advertise eth0:2375 --cluster-store consul://192.168.0.100:8500
```

> Important note: `tcp://0.0.0.0:2375` is insecure and should only be used with an air-gap or in an isolated dev environment. It means anyone with access could potentially run any code on your machine.

### Step 2b Assign static IP addresses to your nodes (optional)

Edit `/etc/systemd/network/eth0.network` and replace it with the following (change the IP address):

```
[Match]
Name=eth0

[Network]
Address=192.168.0.101/24
Gateway=192.168.0.1
DNS=8.8.8.8
IPForward=ipv4
```

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

