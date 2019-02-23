FROM alpine:latest
MAINTAINER Evgeniy Shumilov <evgeniy.shumilov@gmail.com>

ARG CUID
ARG CGID
ENV CUID "$CUID"
ENV CGID "$CGID"

ADD bin /usr/local/bin
ADD acme.sh /opt/acme.sh

RUN apk update && apk add curl openssl sudo
RUN /usr/local/bin/createuser

USER acme
WORKDIR /home/acme

ENV PS1='\\[\\e[1;32m\\]\u\[\e[1;33m\]@\[\e[1;32m\]\h \[\e[1;33m\][\[\e[1;36m\]$([ $? -eq 0 ] && echo "\\[\\e[1;32m\\]$?" || echo "\\[\\e[1;31m\\]$?")\[\e[1;33m\]]\[\e[0;33m\]:\[\e[1;33m\][\[\e[1;34m\]\t\[\e[1;33m\]]\[\e[0;33m\]:\[\e[1;33m\][\[\e[1;36m\]\w\[\e[1;33m\]\\[\e[1;33m\]]\[\e[1;31m\]\\[\\e[1;32m\\]\$ \[\e[0m\]'

ENTRYPOINT /usr/local/bin/entry.sh
