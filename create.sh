#!/bin/bash

containerName="sys-container"
imageName="sys"

echo "Running docker create"


touch $HOME/.vimrc
touch $HOME/.bashrc
touch $HOME/

docker create -it --runtime=nvidia \
         --name $containerName \
         --net host \
         --privileged \
         --shm-size 4G \
         --user $USER \
         -v $HOME/:$HOME \
         -v $HOME/.vimrc:$HOME/.vimrc \
         -v $HOME/.bashrc:$HOME/.bashrc \
         -v $HOME/.cache/bazel:$HOME/.cache/bazel \
         -v $HOME/.bash_history:$HOME/.bash_history \
         -v /tmp/.X11-unix:/tmp/.X11-unix \
         -e DISPLAY=$DISPLAY \
         -e CONTAINER_NAME=$containerName \
         -h $containerName $imageName
