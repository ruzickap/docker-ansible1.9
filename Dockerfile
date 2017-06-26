# Latest version of centos
FROM centos:latest
MAINTAINER Petr Ruzicka <petr.ruzicka@gmail.com>

# Update base image
RUN yum -y update; yum clean all

RUN yum -y install epel-release; yum clean all

RUN yum -y install http://mirror.oasis.onnetcorp.com/epel/testing/7/x86_64/a/ansible1.9-1.9.6-2.el7.noarch.rpm ansible-lint openssh-clients python-boto python2-boto3 python-dns python-netaddr sudo; yum clean all

RUN groupadd -r ansible -g 433 && \
    useradd -u 431 -r -g ansible -d /home/ansible -s /sbin/nologin -c "Ansible Docker image user" ansible && \
    mkdir -p /home/ansible/.ansible/{tmp,cp}

ENV HOME=/home/ansible
ENV USER=ansible

USER root

VOLUME /home/ansible/ansible_project

WORKDIR /home/ansible/ansible_project

# default command:
CMD [ "ansible-playbook" ]
