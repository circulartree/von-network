#!/bin/bash

USAGE="Usage: $(basename "$0") seed_1 seed_2
Deploy demo ledger

where:
  seed_1  Wallet seed for demo connector 1
  seed_2  Wallet seed for demo connector 2"

if [ $# -lt 2 ]; then
  echo 1>&2 "$0: missing arguments"
  echo "$USAGE" >&2
  exit 2
fi
DEMO_CONNECTOR_1_SEED=$1
DEMO_CONNECTOR_2_SEED=$2

cd /home/ubuntu/von-network

./manage rm

./manage build
./manage up --wait

echo "Registering DIDs" >&2
until $(curl --output /dev/null --silent --fail -X POST http://localhost:9000/register -H "Content-Type: application/json" -d '{"did": null, "seed": "'${DEMO_CONNECTOR_1_SEED}'"}'); do
    printf "."
    sleep 1
done
until $(curl --output /dev/null --silent --fail -X POST http://localhost:9000/register -H "Content-Type: application/json" -d '{"did": null, "seed": "'${DEMO_CONNECTOR_2_SEED}'"}'); do
    printf "."
    sleep 1
done
