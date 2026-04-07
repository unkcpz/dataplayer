#!/bin/bash

set -e # stop on error

if [ $# -lt 1 ]; then
  echo "bad usage"
  exit 1
fi

filePath=$1

curl -X PUT -H "apikey:$apikey" $url/path/$filePath
