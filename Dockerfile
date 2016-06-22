FROM jenkinsci/jenkins:2.9

RUN wget http://hyper-install.s3.amazonaws.com/hyper-test-x86_64.tar.gz -O /tmp/hyper-test-x86_64.tar.gz && cd /usr/bin/ && tar xzvf /tmp/hyper-test-x86_64.tar.gz
ADD .hyper/config /.hyper/config
ADD .hyper/config /root/.hyper/config
