FROM node:alpine

ENV IOTA_NODE_URL="http://iota:14265"

EXPOSE 9311

RUN build_deps="python alpine-sdk git ncurses" && \
    apk add -U dumb-init $build_deps && \
    git clone https://github.com/crholliday/iota-prom-exporter.git && \
    cd iota-prom-exporter && \
    npm install && \
    apk del $build_deps && \
    mkdir /config && \
    ln -s /config/config.js && \
    rm -f /var/cache/apk/*

WORKDIR /iota-prom-exporter

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
