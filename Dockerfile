FROM ubuntu:15.10
MAINTAINER antoninfant <antoninfant>

ENV OVFTOOL_FILENAME=VMware-ovftool-4.1.0-2459827-lin.x86_64.bundle

ADD $OVFTOOL_FILENAME /tmp/

WORKDIR /root

RUN /bin/sh /tmp/$OVFTOOL_FILENAME --console --required --eulas-agreed && \
    rm -f /tmp/$OVFTOOL_FILENAME

ENTRYPOINT ["ovftool"]
