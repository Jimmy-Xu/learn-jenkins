使用`docker-slaves-plugin` build job时，调用的docker cli列表如下:

```
//所需容器：
- plumbing容器: plumbing 'jenkins-slave' container
- build容器:    user's build container


//创建data volume
[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - createVolume()
----------------------------
$ docker -H tcp://127.0.0.1:2375 volume create --driver local
----------------------------

//创建plumbing容器
[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - createRemotingContainer()
----------------------------
$ docker -H tcp://127.0.0.1:2375 create --interactive --log-driver=none --env TMPDIR=/home/jenkins/.tmp --user 10000:10000 --volume f7cf7f883ca06750c03d15a84be7b83286c74ffa88a342312bf3ff17a7cd7006:/home/jenkins/ --workdir /home/jenkins/ jenkinsci/slave java -Djava.io.tmpdir=/home/jenkins/.tmp -jar /home/jenkins/slave.jar
----------------------------


[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - putFileContent()
----------------------------
$ docker -H tcp://127.0.0.1:2375 cp - d73e234626f99109f5926192a5b3d07e21471e40a01dc76443579d56a9f45310:/home/jenkins/
----------------------------

//启动plumbing容器
[launchRemotingContainer()] caller => DockerProvisioner.java - it.dockins.dockerslaves.DockerProvisioner - launchRemotingContainer()
----------------------------
$ docker -H tcp://127.0.0.1:2375 start --interactive --attach d73e234626f99109f5926192a5b3d07e21471e40a01dc76443579d56a9f45310
----------------------------
Jul 20, 2016 3:17:00 PM hudson.slaves.CommandLauncher launch
INFO: slave agent launched for Container for docker-slaves-plugin-test#17
Jul 20, 2016 3:17:00 PM hudson.tasks.Shell$DescriptorImpl getShellOrDefault


//检查用户image是否存在
[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - checkImageExists()
----------------------------
$ docker -H tcp://127.0.0.1:2375 inspect -f '{{.Id}}' ubuntu
----------------------------

//创建build容器
[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - createAndLaunchBuildContainer()
----------------------------
$ docker -H tcp://127.0.0.1:2375 create --env TMPDIR=/home/jenkins/.tmp --workdir /home/jenkins --volumes-from d73e234626f99109f5926192a5b3d07e21471e40a01dc76443579d56a9f45310 --net=container:d73e234626f99109f5926192a5b3d07e21471e40a01dc76443579d56a9f45310 --ipc=container:d73e234626f99109f5926192a5b3d07e21471e40a01dc76443579d56a9f45310 --user 10000:10000 ubuntu /trampoline wait
----------------------------

[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - getFileContent()
----------------------------
$ docker -H tcp://127.0.0.1:2375 cp bf559aa219120618f810c9502c6fa62fcf34cdbc08a41b41f8d0f05f1108f773:/etc/group -
----------------------------

[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - putFileContent()
----------------------------
$ docker -H tcp://127.0.0.1:2375 cp - bf559aa219120618f810c9502c6fa62fcf34cdbc08a41b41f8d0f05f1108f773:/etc
----------------------------

[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - getFileContent()
----------------------------
$ docker -H tcp://127.0.0.1:2375 cp bf559aa219120618f810c9502c6fa62fcf34cdbc08a41b41f8d0f05f1108f773:/etc/passwd -
----------------------------

[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - putFileContent()
----------------------------
$ docker -H tcp://127.0.0.1:2375 cp - bf559aa219120618f810c9502c6fa62fcf34cdbc08a41b41f8d0f05f1108f773:/etc
----------------------------

[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - putFileContent()
----------------------------
$ docker -H tcp://127.0.0.1:2375 cp - bf559aa219120618f810c9502c6fa62fcf34cdbc08a41b41f8d0f05f1108f773:/
----------------------------

//启动build容器
[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - createAndLaunchBuildContainer()
----------------------------
$ docker -H tcp://127.0.0.1:2375 start bf559aa219120618f810c9502c6fa62fcf34cdbc08a41b41f8d0f05f1108f773
----------------------------

//在容器中执行job
[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - execInContainer()
----------------------------
$ docker -H tcp://127.0.0.1:2375 exec bf559aa219120618f810c9502c6fa62fcf34cdbc08a41b41f8d0f05f1108f773 /trampoline cdexec /home/jenkins/workspace/docker-slaves-plugin-test env BUILD_DISPLAY_NAME=#17 BUILD_ID=17 BUILD_NUMBER=17 BUILD_TAG=jenkins-docker-slaves-plugin-test-17 BUILD_URL=http://192.168.1.137:8080/jenkins/job/docker-slaves-plugin-test/17/ CA_CERTIFICATES_JAVA_VERSION=20140324 CLASSPATH= EXECUTOR_NUMBER=0 HOME=/home/jenkins HOSTNAME=d73e234626f9 HUDSON_HOME=/home/xjimmy/gopath/src/github.com/Dockins/docker-slaves-plugin/work HUDSON_SERVER_COOKIE=1c19a60cfeb996f5 HUDSON_URL=http://192.168.1.137:8080/jenkins/ JAVA_DEBIAN_VERSION=8u66-b01-1~bpo8+1 JAVA_VERSION=8u66 JENKINS_HOME=/home/xjimmy/gopath/src/github.com/Dockins/docker-slaves-plugin/work JENKINS_SERVER_COOKIE=1c19a60cfeb996f5 JENKINS_URL=http://192.168.1.137:8080/jenkins/ JOB_NAME=docker-slaves-plugin-test JOB_URL=http://192.168.1.137:8080/jenkins/job/docker-slaves-plugin-test/ LANG=C.UTF-8 "NODE_LABELS=Container for docker-slaves-plugin-test#17" "NODE_NAME=Container for docker-slaves-plugin-test#17" PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin TMPDIR=/home/jenkins/.tmp WORKSPACE=/home/jenkins/workspace/docker-slaves-plugin-test /bin/sh -xe /home/jenkins/.tmp/hudson5882700856447905595.sh
----------------------------
Jul 20, 2016 3:17:04 PM hudson.model.Run execute
INFO: docker-slaves-plugin-test #17 main build action completed: SUCCESS
Jul 20, 2016 3:17:06 PM it.dockins.dockerslaves.DockerComputer terminate
INFO: Stopping Docker Slave after build completion

//job执行完，删除容器
[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - removeContainer()
----------------------------
$ docker -H tcp://127.0.0.1:2375 rm -f bf559aa219120618f810c9502c6fa62fcf34cdbc08a41b41f8d0f05f1108f773
----------------------------
Jul 20, 2016 3:17:08 PM it.dockins.dockerslaves.DockerComputer terminate
INFO: Stopping Docker Slave after build completion

[launchDockerCLI()] caller => CliDockerDriver.java - it.dockins.dockerslaves.drivers.CliDockerDriver - removeContainer()
----------------------------
$ docker -H tcp://127.0.0.1:2375 rm -f bf559aa219120618f810c9502c6fa62fcf34cdbc08a41b41f8d0f05f1108f773
----------------------------
```
