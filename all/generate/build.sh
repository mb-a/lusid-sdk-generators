#!/bin/bash

if [[ ${#1} -eq 0 ]]; then
    echo
    echo "No language specified"
    exit 1
fi

if [[ ${#2} -eq 0 ]]; then
    echo
    echo "[ERROR] url for swagger file not specified"
    exit 1
fi

cd ../../$1/generate

# get the specificed swagger file
curl -L $2 -o lusid.json

mkdir -p output

cp .openapi-generator-ignore output/.openapi-generator-ignore
mv lusid.json output/lusid.json

# build the sdk
docker-compose build && docker-compose up && docker-compose rm -f