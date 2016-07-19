Install dependency under Ubuntu
===============================

> Tested under ubuntu(16.04/14.04)

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Install JDK](#install-jdk)
- [Install Maven](#install-maven)
- [Use docker](#use-docker)
	- [Install docker](#install-docker)
	- [Config docker](#config-docker)
	- [Config systemd for docker](#config-systemd-for-docker)
	- [Restart docker daemon](#restart-docker-daemon)

<!-- /TOC -->

# Install JDK

```
$ sudo apt-add-repository ppa:webupd8team/java
$ sudo apt-get update
$ sudo apt-get install oracle-java8-installer
$ java -version

//switch java version when multiple version installed
$ sudo update-alternatives --config java
```


# Install Maven

```
$ sudo apt-get install maven
$ mvn --version
```

# Use docker

## Install docker
```
$ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

//for ubuntu 16.04
$ echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list

//for ubuntu 14.04
$ echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list

$ sudo apt-get update
$ apt-cache policy docker-engine
$ sudo apt-get install -y docker-engine

// allow `aufs` storage driver
$ sudo apt-get install linux-image-extra-$(uname -r)

// add user to docker group
$ sudo usermod -aG docker $(whoami)
```

## Config docker

- enable Docker Remote API
- enable proxy for docker daemon(speed up pull image)

```
$ cat /etc/default/docker
DOCKER_OPTS="-H tcp://0.0.0.0:2375"
http_proxy="http://localhost:8118/"
https_proxy="http://localhost:8118/"
```


## Config systemd for docker

update `EnvironmentFile` and `ExecStart`

```
$ cat /lib/systemd/system/docker.service
...
[Service]
EnvironmentFile=-/etc/default/docker
ExecStart=/usr/bin/docker daemon $DOCKER_OPTS -H fd://
...
```

## Restart docker daemon

```
//reload systemd
$ sudo systemctl daemon-reload

//restart daemon
$ sudo service docker restart

//enable daemon autostart
$ sudo systemctl enable docker
```
