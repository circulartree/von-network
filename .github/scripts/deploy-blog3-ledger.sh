#!/bin/bash

cd /home/ubuntu/von-network

./manage rm

./manage build
./manage up --wait

printf "Registering DIDs" >&2
until $(curl --output /dev/null --silent --fail -X POST http://localhost:9000/register -H "Content-Type: application/json" -d '{"did": null, "seed": "'${DEMO_CONNECTOR_1_SEED}'"}'); do
    printf "."
    sleep 1
done
until $(curl --output /dev/null --silent --fail -X POST http://localhost:9000/register -H "Content-Type: application/json" -d '{"did": null, "seed": "'${DEMO_CONNECTOR_2_SEED}'"}'); do
    printf "."
    sleep 1
done
