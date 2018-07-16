FROM photon

RUN tdnf -y install tar gzip sed gawk ncurses-compat

ADD VMware-ovftool-4.2.0-4586971-lin.x86_64.bundle /tmp/
RUN chmod +x /tmp/VMware-ovftool-4.2.0-4586971-lin.x86_64.bundle

RUN echo -e "/w00t\n" >> /tmp/answer
RUN /tmp/VMware-ovftool-4.2.0-4586971-lin.x86_64.bundle --eulas-agreed --required --console < /tmp/answer

CMD ["/bin/bash"]
