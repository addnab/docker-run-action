#!/usr/bin/env bash

if [ ! -z $INPUT_USERNAME ];
then echo $INPUT_PASSWORD | docker login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi

if [ ! -z $INPUT_DOCKER_NETWORK ];
then INPUT_OPTIONS="$INPUT_OPTIONS --network $INPUT_DOCKER_NETWORK"
fi

if [ $INPUT_QUOTE_ARGUMENT -eq "true" ];
then exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" $INPUT_OPTIONS $INPUT_IMAGE $INPUT_SHELL $INPUT_SCRIPT_PREFIX "${INPUT_RUN//$'\n'/;}"
elif [ $INPUT_QUOTE_ARGUMENT -eq "false" ]; then exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" $INPUT_OPTIONS $INPUT_IMAGE $INPUT_SHELL $INPUT_SCRIPT_PREFIX ${INPUT_RUN}
else 
	echo "Sorry, please specify 'true' or 'false' for the variable quote_argument"
	exit 1
fi
