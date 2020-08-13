FROM ubuntu:18.04
ADD . /
RUN chmod +x /install.sh

RUN /install.sh && rm -rf /tmp && mkdir /tmp && chmod 1777 /tmp

ENV BASH_ENV "/etc/drydock/.env"

