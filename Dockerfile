FROM ubuntu:latest
MAINTAINER antoninfant

ENV OVFTOOL_FILENAME=VMware-ovftool-4.2.0-4586971-lin.x86_64.bundle

ADD $OVFTOOL_FILENAME /tmp/

WORKDIR /root

RUN /bin/sh /tmp/$OVFTOOL_FILENAME --console --required --eulas-agreed && \
    rm -f /tmp/$OVFTOOL_FILENAME  
    
RUN apt-get update --fix-missing

RUN apt-get install -yq build-essential \
      git \
      gcc \
      uuid \
      uuid-dev \
      perl \
      libxml-libxml-perl \
      perl-doc \
      libssl-dev \
      libarchive-zip-perl \
      libcrypt-ssleay-perl \
      libclass-methodmaker-perl \
      libdata-dump-perl \
      libsoap-lite-perl && \
    apt-get clean

# Install vCLI https://developercenter.vmware.com/web/dp/tool/vsphere_cli/6.0
ADD VMware-vSphere-Perl-SDK-6.0.0-2503617.x86_64.tar.gz /tmp/

# Bypass stupid question
RUN sed -i '2621,2634d' /tmp/vmware-vsphere-cli-distrib/vmware-install.pl
RUN /tmp/vmware-vsphere-cli-distrib/vmware-install.pl -d EULA_AGREED=yes

# Thanks to https://kill-9.me/276/vmware-perl-sdk-hanging-login for fix
RUN cp -Rv /tmp/vmware-vsphere-cli-distrib/lib/libwww-perl-5.805/lib/LWP /etc/perl/
RUN sed -i "/Dumper;/a use LWP::Protocol::https10 ();\nLWP::Protocol::implementor('https', 'LWP::Protocol::https10');" /usr/share/perl/5.18/VMware/VICommon.pm && \
    rm -rf /tmp/vmware-vsphere-cli-distrib

# Run Bash when the image starts
CMD ["/bin/bash"]
