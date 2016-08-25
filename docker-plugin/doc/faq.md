FAQ
============

# docker-plugin doesn't support docker 1.12

## error message

> view in /var/log/jenkins.log

```
{"message":"starting container with HostConfig was deprecated since v1.10 and removed in v1.12"}
```

## Related:
```
JENKINS-36080: docker 1.12 breaks plugin because of HostConfig
https://issues.jenkins-ci.org/browse/JENKINS-36080

PR: JENKINS-36080 enable to specify docker api version #418
https://github.com/jenkinsci/docker-plugin/pull/418

issue: "HostConfig at API container start" is removed from Docker 1.12 #403
https://github.com/jenkinsci/docker-plugin/issues/403
```

## Solution:
build from latest code
```
$ git clone https://github.com/jenkinsci/docker-plugin.git
$ cd docker-plugin
$ mvn package -DskipTests
...
[INFO] Generating hpi /home/xjimmy/gopath/src/github.com/jenkinsci/docker-plugin/docker-plugin/target/docker-plugin.hpi
[INFO] Building jar: /home/xjimmy/gopath/src/github.com/jenkinsci/docker-plugin/docker-plugin/target/docker-plugin.hpi
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] Docker-java shaded jar for jenkins plugin .......... SUCCESS [  7.459 s]
[INFO] Docker plugin parent pom ........................... SUCCESS [  8.455 s]
[INFO] Docker plugin ...................................... SUCCESS [  9.683 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
...
```
