#!/bin/bash

setup_docker_env() {
    eval $(docker-machine env $1)
    if [ $? -ne 0 ]; then
        return 1;
    fi
    export DOCKER_HOST_IP_ADDR="$(docker-machine ip $1)"
}

if [[ "$OSTYPE" == "linux-gnu" ]]; then

    _HOST_PLATFORM="linux";
    export DOCKER_HOST_IP_ADDR="172.17.42.1"

elif [[ "$OSTYPE" == "darwin"* ]]; then

    _HOST_PLATFORM="macos x";
    setup_docker_env

elif [[ "$OSTYPE" == "cygwin" ]]; then
    _HOST_PLATFORM="cygwin";
elif [[ "$OSTYPE" == "msys" ]]; then

    _HOST_PLATFORM="msys";
    PATH=$PATH:~/Downloads setup_docker_env $1

elif [[ "$OSTYPE" == "win32" ]]; then
    _HOST_PLATFORM="win32";
elif [[ "$OSTYPE" == "freebsd" ]]; then
    _HOST_PLATFORM="freebsd";
else
    _HOST_PLATFORM="unknown";
fi

echo "Detected OS:" ${_HOST_PLATFORM}
echo "DOCKER_HOST_IP_ADDR:" ${DOCKER_HOST_IP_ADDR}
