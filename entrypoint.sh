#!/usr/bin/env bash

if [ ! -z $INPUT_USERNAME ];
then echo $INPUT_PASSWORD | docker login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi

echo "$INPUT_RUN" | sed -e 's/\\n/;/g' > semicolon_delimited_script

if [ ! -z $INPUT_DOCKER_NETWORK ];
then INPUT_OPTIONS="$INPUT_OPTIONS --network $INPUT_DOCKER_NETWORK"
fi

if [ ! -z $INPUT_SHELL ];
then INPUT_OPTIONS="$INPUT_OPTIONS --entrypoint=$INPUT_SHELL"
fi

exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" $INPUT_OPTIONS $INPUT_IMAGE -c "`cat semicolon_delimited_script`"
