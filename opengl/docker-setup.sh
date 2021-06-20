
#!/usr/bin/env bash

NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'



function cmd () {
  echo -e "$ ${GREEN}$1${NOCOLOR}"
  $1
}


function fail () {
  echo -e "${RED}$1${NOCOLOR}"
  exit 1
}




# Install common and required packages
cmd "sudo apt update"
cmd "sudo apt install -y build-essential curl git git-lfs vim net-tools htop docker.io gnupg-agent"

# Install nvidia-docker
echo -e "* ${BLUE}Creating /etc/apt/sources.list.d/nvidia-docker.list${NOCOLOR}"
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
echo -e "* ${BLUE}Installing GPG key for nvidia-docker${NOCOLOR}"
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
cmd "sudo apt update"
cmd "sudo apt install -y nvidia-docker2"

# Configure nvidia-docker and allow insecure access to our registries
echo -e "* ${BLUE}Creating /etc/docker/daemon.json${NOCOLOR}"
sudo bash -c 'cat > /etc/docker/daemon.json << EOF
{
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    },
    "insecure-registries" : [
        "docker.martian.ag"
    ],
    "data-root": "/home/docker"
}
EOF'

# Create /home/docker if it does not already exist
cmd "sudo mkdir -p /home/docker"
cmd "sudo chown root:docker /home/docker"
cmd "sudo pkill -SIGHUP dockerd"

# Enable docker access for the current user
cmd "sudo gpasswd -a $USER docker"

# Check if we need to restart
if ! id -nG "$USER" | grep -qw "docker"; then
  echo -e "${RED}You must restart before attempting to run docker or vdev-setup.sh${NOCOLOR}"
fi

