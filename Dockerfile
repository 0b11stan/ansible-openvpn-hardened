FROM centos/systemd

RUN yum update -y && yum install -y openssh-server sudo
