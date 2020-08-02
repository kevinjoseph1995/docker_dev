#!/bin/bash
containerName="sys-container"
[ ! "$(docker ps -aq -f name=$containerName -f status=running)" ] && docker start $containerName >/dev/null
docker exec -it -e COLUMNS=$(tput cols) -e LINES=$(tput lines) -w=$PWD $containerName bash "$@"

