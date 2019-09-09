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

if [[ ${#3} -eq 0 ]]; then
    echo
    echo "[ERROR] output folder not specified"
    exit 1
fi

output_folder=$3

cd ../../$1/generate

mkdir -p output/sdk

cp -R $output_folder/ ./output

rm -rf ./output/.git

# get the specificed swagger file
curl -L $2 -o lusid.json

cp ../../all/generate/docker-compose.yml docker-compose.yml

cp .openapi-generator-ignore output/.openapi-generator-ignore
mv lusid.json output/lusid.json

# build the sdk
docker-compose build && docker-compose up && docker-compose rm -f

rm -f docker-compose.yml

cp -R ./output/. $output_folder
rm -rf output