ARCH="$(uname -p)"

if [ $ARCH != "x86_64" ]; then
    echo "ARCH is $ARCH, only run this script in x86_64"
    exit 1
fi  

containerName="dev-${USER}"
docker start $containerName
