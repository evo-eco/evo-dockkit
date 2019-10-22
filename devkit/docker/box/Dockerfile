
FROM evo/devkit:sshd

## NOTES: https://github.com/defn/docker-systemd

## TODO: HOW TO SET A USER NAMED pi

#RUN apt-get install -y openssh-server iptables

RUN passwd -d root
RUN mkdir -p /root/.ssh

ADD authorized_keys /root/.ssh/authorized_keys

RUN chown root:root /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

#RUN

ENTRYPOINT ["/sbin/init", "--log-target=journal"]

CMD []