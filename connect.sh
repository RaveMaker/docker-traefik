#! /bin/bash

# Connect the Traefik container to all frontend networks.

docker=/usr/bin/docker
proxyContainerName=traefik_reverse-proxy_1

${docker} network ls --filter NAME=frontend --format "{{.Name}}" | while read networkName
do
    echo "Connecting $proxyContainerName to $networkName"
    ${docker} network connect ${networkName} ${proxyContainerName}
    if [[ $? -eq 0 ]] ; then
	    echo "Connected"
    fi
done
