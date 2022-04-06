#!/bin/bash

USAGE="Usage: $(basename "$0") ip
Start ledger

where:
  ip  IP address of this server
"

if [ $# -lt 1 ]; then
  echo 1>&2 "$0: missing arguments"
  echo "$USAGE" >&2
  exit 2
fi
DEMO_LEDGER_IP=$1

cd /home/ubuntu/von-network

./manage rm

./manage rebuild
./manage up ${DEMO_LEDGER_IP} --wait
