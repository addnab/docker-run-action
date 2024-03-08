#!/usr/bin/env bash

if [ ! -z $INPUT_USERNAME ];
then echo $INPUT_PASSWORD | docker login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi

if [ ! -z $INPUT_DOCKER_NETWORK ];
then INPUT_OPTIONS="$INPUT_OPTIONS --network $INPUT_DOCKER_NETWORK"
fi

# NOTE: Docker sock may not always be under /var/run/docker.sock
# Rely on DOCKER_HOST if it exists.
# Ref: https://docs.docker.com/engine/reference/commandline/cli/
DOCKER_HOST="${DOCKER_HOST:-unix:///var/run/docker.sock}"
DOCKER_HOST="${DOCKER_HOST#unix://}"

exec docker run -v "${DOCKER_HOST}":"${DOCKER_HOST}" $INPUT_OPTIONS --entrypoint=$INPUT_SHELL $INPUT_IMAGE -c "${INPUT_RUN//$'\n'/;}"
