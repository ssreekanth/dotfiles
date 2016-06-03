#!/bin/bash

SCRIPTNAME=`basename $0`

if [ "$#" -ne 1 ]; then
    echo -e "Error: Wrong arguments.\nUsage: ${SCRIPTNAME} <docker-container>"
    exit
fi

CONTAINER_NAME=$1
CONTAINER_SSH_PORT=`docker port ${CONTAINER_NAME} 22/tcp | cut -d ":" -f 2`

echo "sshing to ${DOCKER_HOST_IP_ADDR}:${CONTAINER_SSH_PORT}"

ssh -X root@${DOCKER_HOST_IP_ADDR} -p ${CONTAINER_SSH_PORT}
