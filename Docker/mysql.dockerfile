FROM mysql:latest
MAINTAINER Kaique de Miranda
WORKDIR /etc/sinc/plen
ENTRYPOINT chmod 755 /etc/sinc
EXPOSE 1711
