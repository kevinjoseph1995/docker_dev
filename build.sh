#!/bin/bash

#Verdant docker development environment

imageName="sys"

echo "Running docker build"

USERID=$(id -u)

docker build -t $imageName - << EOF
FROM system

RUN useradd -ms /bin/bash $USER -u $USERID
ARG DEBIAN_FRONTEND=noninteractive

# create the same user in docker as in outside
RUN apt-get update
RUN apt-get install sudo
RUN  mkdir -p /home/$USER &&  \
    echo "$USER:x:1000:1000:$USER,,,:/home/$USER:/bin/bash" >> /etc/passwd && \
    echo "$USER:x:1000:" >> /etc/group && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER && \
    chown $USER:$USER -R /home/$USER


USER $USER
ENV HOME /home/$USER
WORKDIR /home/$USER
ENV PS1 '\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

EOF
