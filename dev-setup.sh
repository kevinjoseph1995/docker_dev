#!/bin/bash
./build-dev-image.sh
./build.sh

CONTAINER_NAME="dev-${USER}"
OLD="$(docker ps --all --quiet --filter=name="$CONTAINER_NAME")"
if [ -n "$OLD" ]; then
  docker stop $OLD && docker rm $OLD
fi

./create.sh
./start.sh