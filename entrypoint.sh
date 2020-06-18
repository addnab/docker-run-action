#!/usr/bin/env bash

if [ ! -z $INPUT_USERNAME ];
then echo $INPUT_PASSWORD | docker login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi

echo "$INPUT_RUN" | sed -e 's/\\n/;/g' > semicolon_delimited_script

exec docker run $INPUT_OPTIONS --entrypoint=$INPUT_SHELL $INPUT_IMAGE -c "`cat semicolon_delimited_script`"
