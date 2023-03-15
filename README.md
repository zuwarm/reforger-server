# Arma Reforger dedicated server Docker Linux

## Build the basic image
    docker build -t reforger:test .

## Build container from image
Edit and run:

    ./new_reforger_container.sh

A config file must be provided as `live.json`.

## Start/Stop game container
Start: This will also install or update steamcmd and the game on every start (if needed).

    docker start reforger-server

Stop:

    docker stop reforger-server

Watch container logs

    docker logs reforger-server --follow

## Remove the container
    docker rm reforger-server

## Debug a running container
    docker exec -it reforger-server bash


