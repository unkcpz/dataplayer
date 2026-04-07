#!/bin/bash

set -e # stop on error

curl -H "apikey:$apikey" "$url"/user/externalKeys | jq .
