#!/bin/bash

if [[ ${#1} -eq 0 ]]; then
    echo
    echo "No language specified"
    exit 1
fi

if [[ ${#2} -eq 0 ]]; then
    echo
    echo "[ERROR] input folder not specified"
    exit 1
fi

if [[ (${#3} -eq 0) ]] ; then
    echo
    echo "[ERROR] missing API key"
    echo
    exit 1
fi

if [[ (${#4} -eq 0) ]] ; then
    echo
    echo "[ERROR] missing repo name/url"
    echo
    exit 1
fi

input_folder=$2

cd ../../$1/publish

docker build -t finbourne/lusid-sdk-"$1"-publish .

mkdir -p input
mkdir -p input/sdk

cp -R $input_folder/* ./input

cp publish.sh ./input/sdk

cd ./input/sdk

docker run -v /$(pwd):/usr/src/sdk/ finbourne/lusid-sdk-$1-publish publish.sh $3 $4

cd ../../

rm -rf input

