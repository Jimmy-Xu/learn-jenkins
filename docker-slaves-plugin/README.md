Run docker-slaves-plugin from source
====================================

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Prepare](#prepare)
	- [dependency](#dependency)
		- [install docker](#install-docker)
			- [for centos(7.2)](#for-centos72)
			- [for ubuntu(16.04)](#for-ubuntu1604)
		- [install JDK](#install-jdk)
			- [for ubuntu](#for-ubuntu)
			- [for centos](#for-centos)
		- [install Maven](#install-maven)
			- [for ubuntu](#for-ubuntu)
			- [for centos](#for-centos)
	- [fetch plugin source](#fetch-plugin-source)
	- [modify pom.xml](#modify-pomxml)
	- [start Jenkins server](#start-jenkins-server)
	- [open Jenkins Web UI](#open-jenkins-web-ui)
- [Plugin usage](#plugin-usage)
	- [plugin settings](#plugin-settings)
		- [check installed plugin](#check-installed-plugin)
		- [config plugin](#config-plugin)
	- [job settings](#job-settings)
		- [create job](#create-job)
		- [config job](#config-job)
		- [build job](#build-job)
		- [view result](#view-result)

<!-- /TOC -->

# Prepare

## dependency

- install docker
- install JDK 1.8
- install maven 3

### install docker

#### for centos(7.2)

**install**
```
$ sudo yum -y install docker
```

**config /etc/sysconfig/docker**

- enable Docker Remote API
- enable proxy for docker daemon(speed up pull image)

```
$ cat /etc/sysconfig/docker
DOCKER_OPTS='-H tcp://0.0.0.0:2375'
http_proxy=http://localhost:8118
https_proxy=http://localhost:8118
```

**config /lib/systemd/system/docker.service**

update `EnvironmentFile` and `ExecStart`

```
$ vi /lib/systemd/system/docker.service
...
[Service]
EnvironmentFile=-/etc/sysconfig/docker
ExecStart=/usr/bin/docker daemon $DOCKER_OPTS -H fd://
...
```

**restart docker daemon**
```
//reload systemd
$ sudo systemctl daemon-reload

//restart docker daemon
$ service docker restart

//enable docker daemon autostart
$ sudo systemctl enable docker
```

#### for ubuntu(16.04)

**install**
```
$ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
$ echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
$ sudo apt-get update
$ apt-cache policy docker-engine
$ sudo apt-get install -y docker-engine
$ sudo systemctl status docker
$ sudo usermod -aG docker $(whoami)
```

**config /etc/default/docker**

- enable Docker Remote API
- enable proxy for docker daemon(speed up pull image)

```
$ cat /etc/default/docker
DOCKER_OPTS="-H tcp://0.0.0.0:2375"
http_proxy="http://localhost:8118/"
https_proxy="http://localhost:8118/"
```


**config /lib/systemd/system/docker.service**

update `EnvironmentFile` and `ExecStart`

```
$ vi /lib/systemd/system/docker.service
...
[Service]
EnvironmentFile=-/etc/default/docker
ExecStart=/usr/bin/docker daemon $DOCKER_OPTS -H fd://
...
```

**restart docker daemon**

```
//reload systemd
$ sudo systemctl daemon-reload

//restart docker daemon
$ sudo service docker restart

//enable docker daemon autostart
$ sudo systemctl enable docker
```


### install JDK

#### for ubuntu

```
$ sudo apt-add-repository ppa:webupd8team/java
$ sudo apt-get update
$ sudo apt-get install oracle-java8-installer
$ java -version

//switch java version when multiple version installed
$ sudo update-alternatives --config java
```

#### for centos

```
$ curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k https://edelivery.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.rpm
$ sudo yum install -y jdk-8u91-linux-x64.rpm
$ java -version

//switch java version when multiple version installed
$ sudo alternatives --config java
```

### install Maven

#### for ubuntu

```
$ sudo apt-get install maven
$ mvn --version
```

#### for centos

```
$ sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
$ sudo yum install -y apache-maven
$ mvn --version
```

## fetch plugin source
```
$ git clone https://github.com/Dockins/docker-slaves-plugin.git
```

## modify pom.xml

**change**

```
<dependency>
    <groupId>org.jenkins-ci.plugins</groupId>
    <artifactId>docker-java-api</artifactId>
    <version>3.0.0-SNAPSHOT</version>
    <optional>true</optional>
</dependency>
```

**to**

```
<dependency>
    <groupId>com.github.docker-java</groupId>
    <artifactId>docker-java</artifactId>
    <version>3.0.0</version>
</dependency>
```

## start Jenkins server
```
mvn hpi:run
```

## open Jenkins Web UI
```
open http://127.0.0.1:8080/jenkins in Web Browser
```

# Plugin usage

## plugin settings

### check installed plugin
```
Manage Jenkins -> Manage Plugins -> Installed -> "Docker Slaves Plugin"
```

### config plugin
```
Manage Jenkins -> Configure System -> Docker Slaves
  -> Docker Host URI  : tcp://127.0.0.1:2375(example)
  -> Docker API Client: Docker CLI
```

## job settings

### create job
```

```

### config job
```
```

### build job
```
```

### view result
```
```
