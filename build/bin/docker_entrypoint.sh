#!/bin/bash

#set -euo pipefail

btc_prune=${BTC_PRUNE:-0}
if [ $btc_prune -ne 0 ] ; then
    BTC_TXINDEX=0
fi

BITCOIN_DIR=/root/.bitcoin
BITCOIN_CONF=${BITCOIN_DIR}/bitcoin.conf

echo 'findthis'
ls /root/.bitcoin
#cat /root/.bitcoin/bitcoin.conf
ls /root/.bitcoin/bitcoin.conf
echo 'findthis2'

# No need to overwrite or create the bitcoin.conf file here.

if [ $# -eq 0 ]; then
    cat ${BITCOIN_CONF}
    exec bitcoind -datadir=${BITCOIN_DIR} -conf=${BITCOIN_CONF}
else
    exec "$@"
fi
