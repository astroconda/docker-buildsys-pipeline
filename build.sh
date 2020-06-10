#!/bin/bash

tag="$1"
if [[ ! $tag ]]; then
    echo "No tag specified."
    exit 1
fi

url="$2"
if [[ ! $url ]]; then
    echo "No published snapshot URL specified."
    exit 1
fi

docker build \
    -t "astroconda/buildsys-pipeline:${tag}" \
    --build-arg SNAPSHOT_URL="${url}" $(pwd)
