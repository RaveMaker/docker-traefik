#! /bin/bash

# Connect the Traefik container to all frontend networks.

docker=/usr/bin/docker
proxyContainterName=traefik_reverse-proxy_1

$docker network ls --filter NAME=frontend --format "{{.Name}}" | while read networkName
do
    echo "Connecting $proxyContainterName to $networkName"
    $docker network connect $networkName $proxyContainterName
    if [ $? -eq 0 ] ; then
	echo "Connected"
    fi
done
