FROM fedora:22
MAINTAINER "Antony Antony" <antony@phenome.org>
ENV container docker
RUN dnf -y update; dnf clean all
RUN dnf -y install systemd; dnf clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN dnf install -y wget vim-enhanced bison flex nss-devel \
 nspr-devel nss-tools  gcc make unbound-libs ipsec-tools pexpect racoon2 \
 nc6 unbound-devel fipscheck-devel libcap-ng-devel git pam-devel \
 audit-libs-devel strace unbound pexpect net-tools bind-utils \
 rpm-build nc psmisc lsof valgrind ElectricFence screen xl2tpd \
 curl-devel pam-devel redhat-rpm-config openldap-devel hping3 nmap mtr \
 libevent-devel pyOpenSSL xmlto dnf-plugins-core python3-cryptography \
 tcpdump trousers traceroute telnet;
RUN dnf clean all;
RUN dnf -y  debuginfo-install ElectricFence audit-libs cyrus-sasl glibc keyutils \
 krb5-libs ldns libcap-ng libcom_err libcurl libevent libgcc libidn libselinux \
 libssh2 nspr nss nss-softokn nss-softokn-freebl nss-util openldap \
 openssl-libs pam pcre python-libs sqlite unbound-libs xz-libs zlib nspr \
 nss libevent-devel; dnf clean all
RUN mkdir -p /home/build/libreswan
VOLUME ["/home/build/libreswan:/home/build/libreswan"]
RUN ln -s /home/build/libreswan/testing /testing
RUN echo " * soft core unlimited" >> /etc/security/limits.conf
RUN echo " DAEMON_COREFILE_LIMIT='unlimited'" >> /etc/sysconfig/pluto
#
#ssh
RUN dnf -y install openssh-server
RUN dnf -y install openssh-clients
RUN mkdir /root/.ssh
RUN mkdir /var/run/sshd
# create host keys
RUN ssh-keygen -b 1024 -t rsa -f /etc/ssh/ssh_host_key
RUN ssh-keygen -b 1024 -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -b 1024 -t dsa -f /etc/ssh/ssh_host_dsa_key
# move public key to enable ssh keys login
# copy the file /root/.ssh/authorized_keys to cwd
ADD authorized_keys /root/.ssh/authorized_keys
RUN chmod 400 /root/.ssh/authorized_keys
RUN chown -R root:root /root/.ssh
RUN  systemctl enable sshd.service
# tell ssh to not use ugly PAM
RUN sed -i 's/UsePAM\syes/UsePAM no/' /etc/ssh/sshd_config
RUN echo "UseDNS no" >> /etc/ssh/sshd_config
# make the terminal prettier
RUN wget ftp://ftp.nohats.ca/pyOpenSSL/python3-pyOpenSSL-0.14-4.fc22.noarch.rpm
RUN wget ftp://ftp.nohats.ca/pyOpenSSL/pyOpenSSL-0.14-4.fc22.noarch.rpm
#RUN rpm -i pyOpenSSL-0.14-4.fc22.noarch.rpm python3-pyOpenSSL-0.14-4.fc22.noarch.rpm
RUN wget ftp://ftp.nohats.ca/ssw/strongswan-debuginfo-5.3.2-1.0.lsw.fc22.x86_64.rpm 
RUN wget ftp://ftp.nohats.ca/ssw/strongswan-debuginfo-5.3.2-1.0.lsw.fc22.x86_64.rpm
#RUN rpm -i strongswan-debuginfo-5.3.1-0.2.lsw.fc22.x86_64.rpm
RUN echo 'export GIT_PS1_SHOWDIRTYSTATE=true' >> /root/.bash_profile
RUN echo 'export PS1="[\u@i\h] \w # "' >> /root/.bash_profile
RUN echo 'export EDITOR=vim' >> /root/.bash_profile
RUN printf '#!/bin/bash\n/home/build/libreswan/testing/guestbin/swan-transmogrify\n'  >> /etc/rc.d/rc.local
RUN chmod a+x /etc/rc.d/rc.local; 
RUN systemctl enable rc-local.service  
RUN printf 'export TERM=xterm\nexport EDITOR=vim\n' > /etc/profile.d/docker_exec_hack.sh
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
