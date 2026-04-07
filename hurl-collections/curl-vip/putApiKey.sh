#!/bin/bash

set -e # stop on error

if [ $# -ne 2 ]; then
  echo "bad usage"
  exit 1
fi

storageId=$1
key=$2

JSON='{"storageIdentifier" : "'$storageId'","apiKey" : "'$key'"}'

curl -X PUT -d "$JSON" -H "Content-Type:application/json;charset=UTF-8" -H "apikey:$apikey" "$url"/user/externalKeys
