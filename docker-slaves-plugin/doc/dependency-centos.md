Install dependency under CentOS
===============================

> Tested under CentOS(7.2.1511)

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Install JDK](#install-jdk)
- [Install Maven](#install-maven)
- [Use Docker](#use-docker)
	- [Install docker](#install-docker)
	- [Config docker](#config-docker)
	- [Config systemd for docker](#config-systemd-for-docker)
	- [Restart docker daemon](#restart-docker-daemon)

<!-- /TOC -->

# Install JDK

```
$ curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k https://edelivery.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.rpm
$ sudo yum install -y jdk-8u91-linux-x64.rpm
$ java -version

//switch java version when multiple version installed
$ sudo alternatives --config java
```


# Install Maven

```
$ sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
$ sudo yum install -y apache-maven
$ mvn --version
```


# Use Docker

## Install docker

```
$ sudo yum -y install docker
```

## Config docker

- enable Docker Remote API
- enable proxy for docker daemon(speed up pull image)

```
$ cat /etc/sysconfig/docker
DOCKER_OPTS='-H tcp://0.0.0.0:2375'
http_proxy=http://localhost:8118
https_proxy=http://localhost:8118
```

## Config systemd for docker

update `EnvironmentFile` and `ExecStart`

```
$ cat /lib/systemd/system/docker.service
...
[Service]
EnvironmentFile=-/etc/sysconfig/docker
ExecStart=/usr/bin/docker daemon $DOCKER_OPTS -H fd://
...
```

## Restart docker daemon
```
//reload systemd
$ sudo systemctl daemon-reload

//restart daemon
$ service docker restart

//enable daemon autostart
$ sudo systemctl enable docker
```
