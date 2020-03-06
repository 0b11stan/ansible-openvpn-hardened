FROM centos/systemd

ARG SSH_USER
ARG SSH_PASS

RUN yum update -y && yum install -y openssh-server sudo
RUN adduser ${SSH_USER} && \
        echo ${SSH_USER}:${SSH_PASS} | chpasswd && \
        usermod -aG wheel ${SSH_USER}
