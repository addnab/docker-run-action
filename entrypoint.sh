#!/usr/bin/env bash

if [ ! -z $INPUT_USERNAME ];
then echo $INPUT_PASSWORD | docker login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi

exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" $INPUT_OPTIONS --network $INPUT_DOCKER_NETWORK --entrypoint=$INPUT_SHELL $INPUT_IMAGE -c "${INPUT_RUN//$'\n'/;}"
