#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 </etc/passwd entry to exploit>"
    exit 1
fi

ARG="$1"
CONTAINER_NAME="john_the_ripper"
IMAGE_NAME="phocean/john_the_ripper_jumbo"

docker pull "$IMAGE_NAME"

docker run --rm -dit --name "$CONTAINER_NAME" "$IMAGE_NAME"

echo "Waiting for container to start..."
sleep 2

echo "Cracking password..."
docker exec -i "$CONTAINER_NAME" /bin/sh -c "
    echo '$ARG' > ~/flag01.passwd && 
    cd /jtr/run && 
    ./john ~/flag01.passwd
    ./john --show ~/flag01.passwd
"

