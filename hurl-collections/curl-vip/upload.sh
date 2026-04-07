#!/bin/bash

set -e # stop on error

if [ $# -lt 2 ]; then
  echo "bad usage"
  exit 1
fi

filePath=$1
uploadFile=$2

curl -X PUT -d @$uploadFile -H "apikey:$apikey" $url/path/$filePath
