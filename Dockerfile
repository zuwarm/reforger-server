FROM debian:bullseye-slim

LABEL maintainer="anti"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && apt-get install -y \
        lib32gcc-s1 \
        wget \
        ca-certificates \
        libcurl4 \
        libssl1.1 \
        curl \
        jq \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /steamcmd \
    && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - -C /steamcmd


RUN echo -e '#!/usr/bin/env bash\n\
/steamcmd/steamcmd.sh +force_install_dir /reforger +login anonymous +app_update 1874900 validate +quit\n\
jq ".gameHostRegisterBindAddress = \"$(curl ifconfig.me)\"" /reforger/Configs/live.json > /reforger/Configs/live.json.tmp && chmod --reference=/reforger/Configs/live.json /reforger/Configs/live.json.tmp && chown --reference=/reforger/Configs/live.json /reforger/Configs/live.json.tmp && mv /reforger/Configs/live.json.tmp /reforger/Configs/live.json\n\
./ArmaReforgerServer -config /reforger/Configs/live.json -backendlog -nothrow -maxFPS 120 -profile /home/profile\n' \ 
> /launch.sh && chmod 755 /launch.sh


WORKDIR /reforger

VOLUME /reforger/Configs

EXPOSE 2001/udp
# EXPOSE 17777/udp

STOPSIGNAL SIGINT

CMD ["/bin/bash","/launch.sh"]

