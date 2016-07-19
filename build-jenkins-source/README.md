use jenkins source
==================

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Build jenkins from source](#build-jenkins-from-source)
	- [Clone repo](#clone-repo)
	- [Build source](#build-source)
	- [Run jenkins server for dev](#run-jenkins-server-for-dev)
	- [Open Jenkins Web UI](#open-jenkins-web-ui)
- [Use jenkins cli](#use-jenkins-cli)
	- [Download jenkins-cli.jar](#download-jenkins-clijar)
	- [Use jenkins-cli.jar](#use-jenkins-clijar)

<!-- /TOC -->

# Build jenkins from source

## Clone repo
```bash
$ git clone https://github.com/jenkinsci/jenkins.git
$ cd jenkins
```

## Build source

```
$ mvn compile
$ mvn test
$ mvn package -DskipTests
```

## Run jenkins server for dev
```bash
$ cd war
$ rm target work -rf    #clear all history data(optional)
$ mvn jenkins-dev:run
```

## Open Jenkins Web UI

open `http://<host-ip>:8080/jenkins` in web browser


# Use jenkins cli

## Download jenkins-cli.jar

open `http://<host-ip>:8080/jenkins/cli` to get the url of jenkins-cli
```
$ wget http://<host-ip>:8080/jenkins/jnlpJars/jenkins-cli.jar
```

## Use jenkins-cli.jar

```bash
$ java -jar jenkins-cli.jar -s http://<host-ip>:8080/jenkins/ help
```
