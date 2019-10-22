
FROM evo/devkit:box

RUN useradd -ms /bin/bash pi

RUN passwd -d pi
RUN mkdir -p /home/pi/.ssh

ADD authorized_keys /home/pi/.ssh/authorized_keys

RUN chown pi:pi /home/pi/.ssh/authorized_keys

ENTRYPOINT ["/sbin/init", "--log-target=journal"]

CMD []