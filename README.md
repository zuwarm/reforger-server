# Arma Reforger dedicated server Docker Linux

## Build the image

    docker build -t reforger:latest .

This might take some time. It contains Steamcmd and Arma server (~7 GB).

Remove the image with:

    docker rmi reforger:latest

It makes sense to rebuild the image after big Arma updates. Otherwise the game gets updated on every launch. This would take time and download bandwidth.

Docker's build cache might keep the big game files, to remove them:

    docker system prune

## Run the server

On every start Steamcmd runs an update check and updates itself and Arma if neccassary.

The container mounts the current directory for Arma config mission files. The last parameter of the docker run command is the Arma config json file.

    docker run \
        -d \
        --rm \
        --name=reforger-server \
        -p 2001:2001/udp \
        -v $PWD:/reforger/configs \
        reforger:latest \
	test.json

## Stop the server

    docker stop reforger-server

The container gets deleted.

## Watch container logs

    docker logs reforger-server --follow

## Debug a running container

    docker exec -it reforger-server bash

Arma log files are in directory `/reforger/log`

## Networking

UDP port 2001 needs to be reachable from outside (in case of NAT). On launch, the container determines the public IP and adds it to the config json file.

Arma only supports IPv4!

