export PS1="\[\e[31m\]tf-docker\[\e[m\] \[\e[33m\]\w\[\e[m\] > "
export TERM=xterm-256color
alias grep="grep --color=auto"
alias ls="ls --color=auto"

echo -e "\e[1;32m"
cat<<VR

 _   __           _           ___                      _     
| | / /          (_)         |_  |                    | |    
| |/ /  _____   ___ _ __       | | ___  ___  ___ _ __ | |__  
|    \ / _ \ \ / / | '_ \      | |/ _ \/ __|/ _ \ '_ \| '_ \ 
| |\  \  __/\ V /| | | | | /\__/ / (_) \__ \  __/ |_) | | | |
\_| \_/\___| \_/ |_|_| |_| \____/ \___/|___/\___| .__/|_| |_|
                                                | |          
                                                |_|  
VR
echo -e "\e[0;32m"
echo "Development image"
echo -e "\e[0;33m"

if [[ $EUID -eq 0 ]]; then
  cat <<WARN
WARNING: You are running this container as root, which can cause new files in
mounted volumes to be created as the root user on your host machine.

To avoid this, run the container by specifying your user's userid:

$ docker run -u \$(id -u):\$(id -g) args...
WARN
fi

# Turn off colors
echo -e "\e[m"