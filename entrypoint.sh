#!/usr/bin/env bash

if [ ! -z "$INPUT_USERNAME" ];
then echo $INPUT_PASSWORD | docker login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi

if [ ! -z "$INPUT_SHELL" ]; then
	INPUT_OPTIONS="$INPUT_OPTIONS --entrypoint=$INPUT_SHELL"
fi

if [ ! -z "$INPUT_ENV" ]; then
	echo "$INPUT_ENV" > env-file
	INPUT_OPTIONS="$INPUT_OPTIONS --env-file env-file"
fi

echo "$INPUT_RUN" | sed -e 's/\\n/;/g' > semicolon_delimited_script

echo docker run -v "/var/run/docker.sock":"/var/run/docker.sock" $INPUT_OPTIONS $INPUT_IMAGE `cat semicolon_delimited_script`
exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" $INPUT_OPTIONS $INPUT_IMAGE `cat semicolon_delimited_script`
