#!/usr/bin/env bash

set -e

# make it so you can run from any directory: https://stackoverflow.com/a/16349776/726368
#cd "${0%/*}"

pushd "${BASH_SOURCE[0]%/*}" > /dev/null

source "../lib/variables.sh"

# colors + exception traps
import util/

# required for logging (bleh, per file)
namespace evo

Log " >>>> BUILD: ./docker/build.sh ($(pwd))"
./docker/build.sh

#Log " >>>> SCAFFOLD: ./docker/build.sh"
#docker-compose -f ${FILE_DOCKER_COMPOSE} up -d

#Log " >>> WAIT:"
#sleep 1;

#Log " >>> SSHd: setup"
#cat ~/.ssh/id_rsa.pub > $(realpath "$PATH_DEVKIT_CONF/authorized_keys")
#docker exec ${NAME_DOCKER_CONTAINER_BOX} passwd -d root
#docker exec ${NAME_DOCKER_CONTAINER_BOX} mkdir -p /root/.ssh/
#Log "${FILE_AUTHORIZED_KEYS} -> ${NAME_DOCKER_CONTAINER_BOX}:/root/.ssh/authorized_keys"
#docker cp ${FILE_AUTHORIZED_KEYS} ${NAME_DOCKER_CONTAINER_BOX}:/root/.ssh/authorized_keys
#docker exec ${NAME_DOCKER_CONTAINER_BOX} chown root:root /root/.ssh/authorized_keys

#Log " >>> SSH: test"

#CONTAINER_HOSTNAME_IN_SSH_CONFIG_FILE="localhost"
#CONTAINER_SSH_NAME="root"
#CONTAINER_SSH_PORT=2221

#source "../vpn/server/scripts/functions-manage-local-hosts-file.sh"
#CONTAINER_IP="127.0.0.1"
#addhost ${CONTAINER_IP} ${CONTAINER_HOSTNAME}

#ssh-keygen -R "[${CONTAINER_HOSTNAME_IN_SSH_CONFIG_FILE}]:$CONTAINER_SSH_PORT"

#echo "ssh -F ./conf/ssh_config -p ${CONTAINER_SSH_PORT} ${CONTAINER_SSH_NAME}@${CONTAINER_HOSTNAME_IN_SSH_CONFIG_FILE} "echo 0""
#ssh -F conf/ssh_config -p ${CONTAINER_SSH_PORT} ${CONTAINER_SSH_NAME}@${CONTAINER_HOSTNAME_IN_SSH_CONFIG_FILE} 'echo'

popd > /dev/null

echo ""
echo ""

DEVKIT_IMAGE_ID_LIST=$(docker images -q -f reference=evo/devkit)
DEVKIT_IMAGE_ID_SYSD=$(docker images -q -f reference=evo/devkit:sysd)
DEVKIT_IMAGE_ID_SSHD=$(docker images -q -f reference=evo/devkit:sshd)
DEVKIT_IMAGE_ID_BOX=$(docker images -q -f reference=evo/devkit:box)

DEVKIT_CONTAINER_ID_BOX=$(docker ps -q -f name=${NAME_DOCKER_CONTAINER_BOX})

function ref() {
    echo "$(UI.Color.Green)$1$(UI.Color.Default)";
}

echo
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo " Welcome to the jungle."
echo ""
echo "  [ IMAGES ]"
echo "      - ../devkit/docker/vpnd/Dockerfile                          [ imageId=$(ref ${DEVKIT_IMAGE_ID_BOX}) ]"
echo "      - ../devkit/docker/vpnd/build.sh                            [ docker images -f reference=evo/devkit:vpnd ]"
echo ""
echo "      - ../devkit/docker/sshd/Dockerfile                          [ imageId=$(ref ${DEVKIT_IMAGE_ID_SSHD}) ]"
echo "      - ../devkit/docker/sshd/build.sh                            [ docker images -f reference=evo/devkit:sshd ]"
echo ""
echo "      - ../devkit/docker/sysd/Dockerfile                          [ imageId=$(ref ${DEVKIT_IMAGE_ID_SYSD}) ]"
echo "      - ../devkit/docker/sysd/build.sh                            [ docker images -f reference=evo/devkit:sysd ]"
echo ""
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'