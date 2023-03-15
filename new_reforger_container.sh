#! /bin/bash
docker create \
        --name=reforger-server \
        -p 2001:2001/udp \
        -v /home/anti/reforger/configs:/reforger/Configs \
        reforger:test
