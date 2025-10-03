FROM debian:trixie-slim

LABEL maintainer="zuwarm"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && apt-get install -y \
        lib32gcc-s1 \
        wget \
        ca-certificates \
        curl \
        jq \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /steamcmd \
    && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - -C /steamcmd

RUN /steamcmd/steamcmd.sh +force_install_dir /reforger +login anonymous +app_update 1874900 validate +quit


RUN echo -e '#!/usr/bin/env bash\n\
[ ! -f "/reforger/configs/$1" ] && echo "--> Missing config file." && exit 1\n\
echo "--> Using config: $1"\n\
if [ -z "$2" ]; then PUBLICPORT=2001; else PUBLICPORT=$2; fi\n\
jq ".publicAddress = \"$(curl -4 ifconfig.me)\" | .publicPort = $PUBLICPORT" /reforger/configs/$1 > /tmp/live.json\n\
echo "--> Updating Reforger Server:"\n\
/steamcmd/steamcmd.sh +force_install_dir /reforger +login anonymous +app_update 1874900 validate +quit\n\
echo "--> Starting Arma Reforger Server:"\n\
./ArmaReforgerServer -config /tmp/live.json -maxFPS 120 -profile /reforger/log\n' \ 
> /launch.sh && chmod 755 /launch.sh


WORKDIR /reforger

VOLUME /reforger/configs

EXPOSE 2001/udp

STOPSIGNAL SIGINT

ENTRYPOINT [ "/launch.sh" ]

