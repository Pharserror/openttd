############################################################
# Dockerfile to build OpenTTD container images
# Based on phusion:baseimage (from ubuntu)
############################################################

FROM phusion/baseimage

MAINTAINER Pharserror <sunboxnet@gmail.com>

ENV OPENTTD_VER 1.7.1
ENV map_x 12
ENV map_y 12
ENV startyear 2017

WORKDIR /tmp/
ADD . /tmp/
RUN /tmp/prepare.sh 
RUN /tmp/system_services.sh
RUN /tmp/cleanup.sh

VOLUME /home/openttd/.openttd

EXPOSE 3979/tcp
EXPOSE 3979/udp

CMD ["/sbin/my_init"]
