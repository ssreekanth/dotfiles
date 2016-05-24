#!/bin/bash

# If users have set CDPATH up in their bash environment, then
# unsetting CDPATH here makes this script to run without any failures.
unset CDPATH

get_script_dir () {
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$( readlink "$SOURCE" )"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    DIR=$( cd -P "$( dirname "$SOURCE" )" && pwd )
    echo "$DIR"
}

#
get_script_name () {
    str=$1
    str=${str/#-}   # remove dash(-) at the start of the string.
    str=${str//\"}  # remove all quotes(") from the string
    str=${str##*/}  # remove prefix till the last backslash(/)
    echo $str
}

DIR="$( get_script_dir )"
SCRIPTNAME="$( get_script_name "${BASH_SOURCE[0]}" )"

# when script is sourced, argument 0 would have shell name.
# when not sourced, it would have the script name.
ARG_0="$( get_script_name "$0" )"

# check if argument 0 is same as scriptname.
if [[ "$ARG_0" == "$SCRIPTNAME" ]]; then
    echo -e "Error: this script needs to be sourced.\nUsage: source ${SCRIPTNAME} <docker-machine-instance>"
    exit 1
fi

# check if argument count is 1. On Linux, this may be irrelevant,
# but user needs to pass something as argument 1.
#if [ "$#" -ne 1 ]; then
#    echo -e "Error: Wrong arguments.\nUsage: source ${SCRIPTNAME} <docker-machine-instance>"
#    return 1
#fi

if [ -z "$1" ]; then
    _DOCKER_MACHINE_INSTANCE="dev"
else
    _DOCKER_MACHINE_INSTANCE=$1
fi

source ${DIR}/docker-common.sh ${_DOCKER_MACHINE_INSTANCE}
if [ $? -eq 1 ]; then
    return 1;
fi

if [ -z "$DOCKER_MACHINE_NAME" ]; then
    _DOCKER_CERT_PATH=${DOCKER_CERT_PATH}
else
    _DOCKER_CERT_PATH=${HOME}"/.docker/machine/machines/"${DOCKER_MACHINE_NAME}
fi
_DOCKER_HOST=${DOCKER_HOST}

echo "DOCKER_CERT_PATH:" ${_DOCKER_CERT_PATH}
echo "DOCKER_HOST:" ${_DOCKER_HOST}

#alias docker-compose='docker run -it --rm -v `pwd`:`pwd`:ro -v /var/run/docker.sock:/var/run/docker.sock:rw --workdir=`pwd` sreekanth/docker-compose'


if [ -z "$DOCKER_CERT_PATH" ]; then
    alias docker-compose='docker run -it --rm -v /`pwd`:`pwd`:ro --workdir=/`pwd` -v /var/run/docker.sock:/var/run/docker.sock:rw sreekanth/docker-compose:1.4.0'
else
    alias docker-compose='docker run -it --rm -v /`pwd`:`pwd`:ro -v /"$_DOCKER_CERT_PATH":/"/docker-certs" --workdir=/`pwd` -e DOCKER_HOST=`echo ${DOCKER_HOST}` -e DOCKER_TLS_VERIFY="1" -e DOCKER_CERT_PATH=/"/docker-certs" sreekanth/docker-compose:1.4.0'
fi
