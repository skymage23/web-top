#!/usr/bin/bash
function die {
   >&2 echo "$@. Dying.".
   exit 1
}

if ! which docker; then
    die "Docker not installed or not on the system PATH";
fi

if ! docker ps 2>&1 >/dev/null; then
    die "User has not been authorized to use Docker"
fi

if [ "$(docker ps -a | grep -i 'build-procps')" == "" ]; then
    echo "Could not find build image."
    echo "Constructing build image."
    docker build -t "build-procps" .
fi

docker run \
-ti \
--name "build-procps" \
--volume=${PWD}:/mnt/procps-ng \
"build-procps"

#Cleanup:
docker rm "build-procps"


