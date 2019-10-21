
FROM ubuntu:18.04

ENV container docker

RUN apt-get update

RUN apt-get install -y dbus systemd

RUN find /etc/systemd -name '*.timer' | xargs rm -v

RUN systemctl set-default multi-user.target

COPY docker-internal-systemd-startup-script.sh /sbin/setup

STOPSIGNAL SIGRTMIN+3

# tbh, we don't really care about file system size.
#      we care about people's time.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/sbin/init", "--log-target=journal"]

CMD []