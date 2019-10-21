#!/usr/bin/env bash

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
cd "${0%/*}"

source "lib/variables.sh"

# colors + exception traps
import util/

# required for logging (bleh, per file)
namespace evo

Log " >>>> RESET: docker-compose down -f docker/docker-compose.yml"
docker-compose -f ${FILE_DOCKER_COMPOSE} down

Log " >>>> BUILD: ./docker/build.sh"
./docker/build.sh

Log " >>>> SCAFFOLD: ./docker/build.sh"
docker-compose -f ${FILE_DOCKER_COMPOSE} up -d

Log " >>> WAIT:"
sleep 1;

Log " >>> SSHd: setup"
cat ~/.ssh/id_rsa.pub > $(realpath "$PATH_DEVKIT_CONF/authorized_keys")

docker exec ${NAME_DOCKER_CONTAINER_VPND} passwd -d root
docker exec ${NAME_DOCKER_CONTAINER_VPND} mkdir -p /root/.ssh/

Log "${FILE_AUTHORIZED_KEYS} -> ${NAME_DOCKER_CONTAINER_VPND}:/root/.ssh/authorized_keys"
docker cp ${FILE_AUTHORIZED_KEYS} ${NAME_DOCKER_CONTAINER_VPND}:/root/.ssh/authorized_keys

docker exec ${NAME_DOCKER_CONTAINER_VPND} chown root:root /root/.ssh/authorized_keys

Log " >>> SSH: test"

CONTAINER_HOSTNAME_IN_SSH_CONFIG_FILE="localhost"
CONTAINER_SSH_NAME="root"
CONTAINER_SSH_PORT=2221

#source "../vpn/server/scripts/functions-manage-local-hosts-file.sh"
#CONTAINER_IP="127.0.0.1"
#addhost ${CONTAINER_IP} ${CONTAINER_HOSTNAME}

ssh-keygen -R "[${CONTAINER_HOSTNAME_IN_SSH_CONFIG_FILE}]:$CONTAINER_SSH_PORT"

echo "ssh -F ./conf/ssh_config -p ${CONTAINER_SSH_PORT} ${CONTAINER_SSH_NAME}@${CONTAINER_HOSTNAME_IN_SSH_CONFIG_FILE} "echo 0""
ssh -F conf/ssh_config -p ${CONTAINER_SSH_PORT} ${CONTAINER_SSH_NAME}@${CONTAINER_HOSTNAME_IN_SSH_CONFIG_FILE} 'echo'

echo ""
echo ""

DEVKIT_IMAGE_ID_LIST=$(docker images -q -f reference=evo/devkit)
DEVKIT_IMAGE_ID_SYSD=$(docker images -q -f reference=evo/devkit:sysd)
DEVKIT_IMAGE_ID_SSHD=$(docker images -q -f reference=evo/devkit:sshd)
DEVKIT_IMAGE_ID_VPND=$(docker images -q -f reference=evo/devkit:vpnd)

DEVKIT_CONTAINER_ID_VPND=$(docker ps -q -f name=${NAME_DOCKER_CONTAINER_VPND})

echo
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo " Welcome to the jungle."
echo ""
echo "      evo/devkit:systemd:"
echo "      evo/devkit:sshd:"
echo "      evo/devkit:devkit_vpnd:"
echo ""
echo "  [ CONTAINERS ]"
echo "      - ../devkit/docker/vpnd                                     [ containerId=$DEVKIT_CONTAINER_ID_VPND ]"
echo "                                                                  [ name=$NAME_DOCKER_CONTAINER_VPND ]"
echo ""
echo "  [ IMAGES ]"
echo "      - ../devkit/docker/vpnd/Dockerfile                          [ imageId=$DEVKIT_IMAGE_ID_VPND ]"
echo "      - ../devkit/docker/vpnd/build.sh                            [ docker images -q -f reference=evo/devkit:vpnd ]"
echo ""
echo "      - ../devkit/docker/sshd/Dockerfile                          [ imageId=$DEVKIT_IMAGE_ID_SSHD ]"
echo "      - ../devkit/docker/sshd/build.sh                            [ docker images -q -f reference=evo/devkit:sshd ]"
echo ""
echo "      - ../devkit/docker/sysd/Dockerfile                          [ imageId=$DEVKIT_IMAGE_ID_SYSD ]"
echo "      - ../devkit/docker/sysd/build.sh                            [ docker images -q -f reference=evo/devkit:sysd ]"
echo ""
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
