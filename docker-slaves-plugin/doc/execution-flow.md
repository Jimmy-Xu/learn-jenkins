Visualize plugin execution flow with Flow Visual Tracer
=======================================================

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Dependency](#dependency)
- [Prepare](#prepare)
	- [Flow Visual Tracer](#flow-visual-tracer)
		- [Download flow.zip](#download-flowzip)
		- [Start Flow Visual Tracer](#start-flow-visual-tracer)
		- [Open Flow Web UI](#open-flow-web-ui)
	- [docker-slaves-plugin](#docker-slaves-plugin)
		- [Get plugin code](#get-plugin-code)
		- [Start Jenkins Server](#start-jenkins-server)
- [Usage](#usage)
	- [Create and config new job](#create-and-config-new-job)
	- [Start record](#start-record)
	- [Build job](#build-job)
	- [Stop recode](#stop-recode)
	- [View flow diagram](#view-flow-diagram)

<!-- /TOC -->

# Dependency

- jdk 1.7+
- maven 3+
- [flow.zip](http://com.flow.launcher.s3-website-eu-west-1.amazonaws.com/flow.zip)  ( from http://findtheflow.io)
- [docker-slaves-plugin](https://github.com/Jimmy-Xu/docker-slaves-plugin)(fork version)

# Prepare

## Flow Visual Tracer

### Download flow.zip
```bash
$ mkdir ~/java-flow
$ cd ~/java-flow
$ wget http://com.flow.launcher.s3-website-eu-west-1.amazonaws.com/flow.zip
$ unzip flow.zip
```

### Start Flow Visual Tracer
```bash
$ ./flow
Java HotSpot(TM) 64-Bit Server VM warning: ignoring option MaxPermSize=256m; support was removed in 8.0
Starting Flow...
Flow is ready on http://app.findtheflow.io (Ctrl+C to stop it)
```

### Open Flow Web UI
open http://app.findtheflow.io in Web Browser of the same host.


## docker-slaves-plugin

use fork version of docker-slaves-plugin: https://github.com/Jimmy-Xu/docker-slaves-plugin

### Get plugin code
```bash
$ git clone https://github.com/Jimmy-Xu/docker-slaves-plugin.git -b hyper-driver
$ cd docker-slaves-plugin
```

### Start Jenkins Server

```bash
$ export MAVEN_OPTS="-javaagent:${HOME}/java-flow/flowagent.jar -Dflow.agent.include=it.dockins.dockerslaves"
$ mvn hpi:run
```

# Usage

## Create and config new job

open http://<host_ip>:8080/jenkins in Web Browser

![](../image/config-job-1.PNG)

## Start record

click `Record` button in http://app.findtheflow.io

![](../image/flow-start-record.PNG)

## Build job

trigger `build` job in Jenkins

![](../image/trigger-build-now.PNG)

## Stop recode

click `Stop` button in http://app.findtheflow.io

![](../image/flow-stop-record.PNG)

## View flow diagram

After click `Stop` button, the flow will be generated automatically. http://app.findtheflow.io
