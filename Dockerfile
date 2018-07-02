FROM ubuntu:15.10
MAINTAINER antoninfant <antoninfant>

RUN apt-get update
RUN apt-get install wget
RUN wget https://my.vmware.com/group/vmware/details?downloadGroup=OVFTOOL410&productId=491
ENV OVFTOOL_FILENAME=VMware-ovftool-4.1.0-2459827-lin.x86_64.bundle

ADD $OVFTOOL_FILENAME /tmp/

WORKDIR /root

RUN /bin/sh /tmp/$OVFTOOL_FILENAME --console --required --eulas-agreed && \
    rm -f /tmp/$OVFTOOL_FILENAME

ENTRYPOINT ["ovftool"]
