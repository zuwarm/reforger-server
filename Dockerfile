FROM debian:bookworm-slim

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


RUN echo -e '#!/usr/bin/env bash\n\
/steamcmd/steamcmd.sh +force_install_dir /reforger +login anonymous +app_update 1874900 validate +quit\n\
jq ".publicAddress = \"$(curl -4 ifconfig.me)\"" /reforger/configs/live.json > /tmp/live.json\n\
./ArmaReforgerServer -config /tmp/live.json -maxFPS 120 -profile /home/profile\n' \ 
> /launch.sh && chmod 755 /launch.sh


WORKDIR /reforger

VOLUME /reforger/configs

EXPOSE 2001/udp
# EXPOSE 17777/udp

STOPSIGNAL SIGINT

CMD ["/bin/bash","/launch.sh"]

