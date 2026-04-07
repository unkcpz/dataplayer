#!/bin/bash

set -e # stop on error

if [ $# -lt 1 ]; then
  echo "bad usage"
  exit 1
fi

filePath=$1

curl -H "apikey:$apikey" $url/path/$filePath?action=list
