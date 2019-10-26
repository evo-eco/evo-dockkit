
### evo-vpn/devkit

### purpose

 * evo-vpn is a set of ansible-playbooks that one-button-setup our prod VPNs. 
 * Those playbooks need to be tested.
 * devkit will spin up testable docker containers for ansible to use for testing. 

### setup

If your box looks like mine, you can run the following:

```bash
$ ./build.sh
```

### reference links

 * https://github.com/gdraheim/docker-systemctl-replacement 
 * https://docs.docker.com/config/daemon/systemd
 * https://github.com/niieani/bash-oo-framework
 * https://github.com/moby/moby/tree/10c0af083544460a2ddc2218f37dc24a077f7d90/docs/reference/commandline
 * https://developers.redhat.com/blog/2014/05/05/running-systemd-within-docker-container/
 * https://stackoverflow.com/questions/51704623/solita-docker-systemd-docker-compose
