install dependency for docker-plugin
====================================

# install package

## install java
oracle jdk 8
```
//install java
$ BASE_URL_8=http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101
$ JDK_VERSION=`echo $BASE_URL_8 | rev | cut -d "/" -f1 | rev`
$ platform="-linux-x64.rpm"
$ wget -c -O "$JDK_VERSION$platform" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "${BASE_URL_8}${platform}"
or
$ curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "${BASE_URL_8}${platform}"
$ sudo yum install -y jdk-8u101-linux-x64.rpm

//select default java
$ alternatives --config java
```

## install jenkins
stable version: 2.7.2
```
//install jenkins 2.7.2
$ sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
$ sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
$ sudo yum install jenkins
or
//goto http://pkg.jenkins-ci.org/redhat-stable/
$ sudo yum install -y http://pkg.jenkins-ci.org/redhat-stable/jenkins-2.7.2-1.1.noarch.rpm

//start jenkins
$ sudo service jenkins start

//view jenkins log
sudo tail -f /var/log/jenkins/jenkins.log
```

## install docker

docker 1.12.1

### install docker engine
```
$ sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

//install
$ sudo yum install -y docker-engine
//upgrade
$ sudo yum upgrade -y docker-engine
```

### config docker

> systemd

- enable remote api
- enable http proxy
- specify storage-driver

```
//config docker
$ sudo cp /lib/systemd/system/docker.service /etc/systemd/system/docker.service
$ sudo mkdir -p /etc/systemd/system/docker.service.d
$ sudo vi /etc/systemd/system/docker.service.d/remote-api.conf
[Service]
Environment="http_proxy=http://127.0.0.1:8118/"
ExecStart=
ExecStart=/usr/bin/dockerd -H tcp://127.0.0.1:2375 -H unix:///var/run/docker.sock --storage-driver=devicemapper

//restart docker service
$ sudo systemctl daemon-reload
$ sudo systemctl restart docker
```

# check dependency

## check java version
```
$ java -version
java version "1.8.0_101"
Java(TM) SE Runtime Environment (build 1.8.0_101-b13)
Java HotSpot(TM) 64-Bit Server VM (build 25.101-b13, mixed mode)
```

## check jenkins
```
//open jenkins web ui: http://<ip>:8080

$ sudo service jenkins status
● jenkins.service - LSB: Jenkins Continuous Integration Server
   Loaded: loaded (/etc/rc.d/init.d/jenkins)
   Active: active (running) since Wed 2016-08-24 22:10:00 CST; 1h 15min ago
     Docs: man:systemd-sysv-generator(8)
   Memory: 801.9M
   CGroup: /system.slice/jenkins.service
           └─2590 /etc/alternatives/java -Dcom.sun.akuma.Daemon=daemonized -Djava.awt.headless=true -DJENKINS_HOME=/var/lib/jenkins -jar /usr/lib/jenkins/jenkins.wa...
```

## check docker service
```
$ sudo service docker status
Redirecting to /bin/systemctl status  docker.service
● docker.service - Docker Application Container Engine
   Loaded: loaded (/etc/systemd/system/docker.service; enabled; vendor preset: disabled)
  Drop-In: /etc/systemd/system/docker.service.d
           └─remote-api.conf
   Active: active (running) since Wed 2016-08-24 23:21:44 CST; 5s ago
     Docs: https://docs.docker.com
 Main PID: 13077 (dockerd)
   Memory: 18.4M
   CGroup: /system.slice/docker.service
           ├─13077 /usr/bin/dockerd -H tcp://127.0.0.1:2375 -H unix:///var/run/docker.sock --storage-driver=devicemapper
           └─13083 docker-containerd -l unix:///var/run/docker/libcontainerd/docker-containerd.sock --shim docker-containerd-shim --metrics-interval=0 --start-timeo...

$ docker info | grep -iE '(proxy|storage)'
or
$ docker -H 127.0.0.1:2375 info | grep -iE '(proxy|storage)'
Storage Driver: devicemapper
Http Proxy: http://127.0.0.1:8118/
```
