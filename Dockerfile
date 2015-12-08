############################################################
# Dockerfile to build OpenTTD container images
# Based on phusion:baseimage (from ubuntu)
############################################################

FROM phusion/baseimage

MAINTAINER Pharserror <sunboxnet@gmail.com>

ENV OPENTTD_VER 1.5.3

WORKDIR /tmp/
ADD . /tmp/
RUN /tmp/prepare.sh 
RUN /tmp/system_services.sh
RUN /tmp/cleanup.sh

VOLUME /home/openttd/.openttd

EXPOSE 3979/tcp
EXPOSE 3979/udp

CMD ["/sbin/my_init"]
