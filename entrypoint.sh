#!/bin/sh

if [ $# == 0 ]; then
  if [ ! -f config.js ]; then
    cat config-template.js | sed \
      -e "s|\(iota_node_url: '\)[^']*|\1$IOTA_NODE_URL|" \
      -e "s|\(bind_address: '\)[^']*|\10.0.0.0|" \
      -e "s|\(zmq_url: '\)[^']*|\1$ZMQ_URL|" \
      -e "s|\(market_info_flag: '\)[^']*|\1$MARKET_INFO_FLAG|" \
      -e "s|\(prune_interval_days: '\)[^']*|\1${PRUNE_INTERVAL_DAYS-1}|" \
      -e "s|\(retention_days: '\)[^']*|\1${RETENTION_DAYS-14}|" \
    > /config/config.js
  fi

  set -- node app.js
fi

exec dumb-init $@
