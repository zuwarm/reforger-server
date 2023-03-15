# Arma Reforger dedicated Server running on Docker Linux

## Build the basic image
docker build -t reforger:test .

## Build container from image
edit and run:
    ./new_reforger_container.sh

## Start/Stop game
Start the container, this will install and update steamcmd and the game on every start (if needed).
    docker start reforger-server
Stop:
    docker stop reforger-server
Watch container logs
    docker logs reforger-server --follow

## Remove the container
    docker rm reforger-server

## Debug a running container
    docker exec -it reforger-server bash


