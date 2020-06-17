#!/usr/bin/env bash

if [ ! -z $INPUT_USERNAME ];
then echo $INPUT_USERNAME | docker login $INPUT_REGISTRY -u $INPUT_PASSWORD --password-stdin
fi

echo $INPUT_COMMAND
echo "running"
exec docker run $INPUT_OPTIONS $INPUT_IMAGE $INPUT_COMMAND
