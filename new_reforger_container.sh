#! /bin/bash
docker create \
        --name=reforger-server \
        -p 2001:2001/udp \
        -v $HOME/reforger/configs:/reforger/Configs \
        reforger:test
