#!/bin/bash

USAGE="Usage: $(basename "$0") seedsfile
Deploy demo ledger

where:
  seedsfile  Absolute path to file with seeds, one per line
"

if [ $# -lt 1 ]; then
  echo 1>&2 "$0: missing arguments"
  echo "$USAGE" >&2
  exit 2
fi
SEEDS_FILE=$1

echo "Registering DIDs" >&2
while read -r seed
do
  until $(curl --output /dev/null --silent --fail -X POST http://localhost:9000/register -H "Content-Type: application/json" -d '{"did": null, "seed": "'${seed}'"}'); do
    printf "."
    sleep 1
  done
done < "${SEEDS_FILE}"
