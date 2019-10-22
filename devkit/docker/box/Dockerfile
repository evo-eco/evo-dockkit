
FROM evo/devkit:sshd

## NOTES: https://github.com/defn/docker-systemd

## TODO: HOW TO SET A USER NAMED pi

#RUN apt-get install -y openssh-server iptables

RUN passwd -d root
RUN mkdir -p /root/.ssh

ADD authorized_keys /root/.ssh/authorized_keys

RUN chown root:root /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

RUN apt-get update
RUN apt-get install -y sudo
#RUN apt-get install -y nslookup

# https://stackoverflow.com/questions/25845538/how-to-use-sudo-inside-a-docker-container/49529946
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#ENTRYPOINT ["/sbin/init", "--log-target=journal"]
#CMD []