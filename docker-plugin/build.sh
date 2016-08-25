#!/bin/bash

case "$1" in
  jnlp)
    docker build -t xjimmyshcn/evarga-jenkins-slave . -f Dockerfile.jnlp
    ;;
  ssh)
    docker build -t xjimmyshcn/ssh-jenkins-slave . -f Dockerfile.ssh
    ;;
  jdk8)
    PROXY="http://172.17.0.1:8118"
    SSH_PUB_KEY=$(cat conf/authorized_keys)
    [ "${PROXY}" != "" ] && BUILD_ARG="--build-arg='PROXY=$PROXY'"
    [ "${SSH_PUB_KEY}" != "" ] && BUILD_ARG=${BUILD_ARG}" --build-arg=\"SSH_PUB_KEY='$SSH_PUB_KEY'\""
cat <<EOF
----------------------------------------------------------------------------------------------------------------------
PROXY       : ${PROXY}
----------------------------------------------------------------------------------------------------------------------
SSH_PUB_KEY : ${SSH_PUB_KEY}
----------------------------------------------------------------------------------------------------------------------
BUILD_ARG   : ${BUILD_ARG}
----------------------------------------------------------------------------------------------------------------------
EOF
    eval "docker build ${BUILD_ARG} -t xjimmyshcn/jdk8-jenksin-slave . -f Dockerfile.jdk8"
     ;;
  *)
    cat <<EOF
usage: ./build.sh jnlp|ssh|jdk8
EOF
    ;;
esac
