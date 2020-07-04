#! /bin/bash

# Connect the Traefik container to all frontend networks.

docker=/usr/bin/docker
proxyContainterName=$(docker ps --filter NAME=traefik_traefik --format "{{.Names}}")

$docker network ls --filter NAME=frontend --format "{{.Name}}" | while read networkName
do
    echo "Connecting $proxyContainterName to $networkName"
    $docker network disconnect $networkName $proxyContainterName
    if [ $? -eq 0 ] ; then
        echo "Disconnected"
    fi
done
