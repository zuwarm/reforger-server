# Arma Reforger dedicated server Docker Linux

## Build the image

    docker build -t reforger:latest .

This might take some time. It contains Steamcmd and ArmaReforger dedicated server (~7 GB).

## Run the server

When starting a container Steamcmd and ArmaReforger might get updated.
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

