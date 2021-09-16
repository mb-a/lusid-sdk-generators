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


ls

cp publish.sh ./input

cd ./input

ls

library_name=$5
library_name=${library_name:=lusid}

docker run -v /$(pwd):/usr/src/ finbourne/lusid-sdk-$1-publish publish.sh $3 $4 $library_name

cd ../

rm -rf input

