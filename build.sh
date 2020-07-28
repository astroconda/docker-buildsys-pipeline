#!/bin/bash

tag="$1"
if [[ ! $tag ]]; then
    echo "No tag specified."
    exit 1
fi

snapshot="$2"
if [[ ! $snapshot ]]; then
    echo "No snapshot file or URL specified."
    exit 1
fi

docker build \
    -t "astroconda/buildsys-pipeline:${tag}" \
    --build-arg SNAPSHOT_INPUT="${snapshot}" $(pwd)
