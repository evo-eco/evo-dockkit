
FROM evo/devkit:sysd

## NOTES: https://github.com/defn/docker-systemd

RUN apt-get install -y openssh-server iptables

ENTRYPOINT ["/sbin/init", "--log-target=journal"]

CMD []