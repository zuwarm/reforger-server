# Arma Reforger dedicated server Docker Linux

## Build the image

    docker build -t reforger:latest .

This might take some time. It contains Steamcmd and Arma server (~7 GB).

Remove the image, if not needed any longer, with:

    docker rmi reforger:latest

It makes sense to rebuild the image after big Arma updates. Otherwise the game gets updated on every launch. This would take time and download bandwidth.

Docker's build cache might keep big game files, even if the image is removed. To remove them:

    docker system prune

## Run the server

On every start, Steamcmd runs an update check and updates itself and Arma, if necassary.

The container mounts the current directory for Arma config files. The last parameter of the docker run command is the Arma config file json.

    docker run -d --rm --name=reforger-server -p 2001:2001/udp -v $PWD:/reforger/configs reforger:latest test.json

Run a second server on port 2002 (optional second parameter).

    docker run -d --rm --name=reforger-server-2 -p 2002:2002/udp -v $PWD:/reforger/configs reforger:latest test.json 2002

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

