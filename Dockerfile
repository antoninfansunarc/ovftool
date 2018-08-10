FROM lamw/vsphere-perl-sdk
MAINTAINER antoninfant

ENV OVFTOOL_FILENAME=VMware-ovftool-4.2.0-4586971-lin.x86_64.bundle

ADD $OVFTOOL_FILENAME /tmp/

WORKDIR /root

RUN /bin/sh /tmp/$OVFTOOL_FILENAME --console --required --eulas-agreed && \
    rm -f /tmp/$OVFTOOL_FILENAME
RUN apt-get install sshpass -y  && \
apt-get install expect -y  && \
mkdir -p /home/m2c2/.ssh && \
touch /home/m2c2/.ssh/known_hosts && \
chmod 777 /home/m2c2/.ssh/known_hosts 

# Run Bash when the image starts
CMD ["/bin/bash"]
