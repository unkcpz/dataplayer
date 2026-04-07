#!/bin/bash

set -e # stop on error

if [ $# -ne 1 ]; then
  echo "bad usage"
  echo "usage   : " $0 "pipeline-identifier"
  echo "example : " $0 "GrepTest/2.4"
  exit 1
fi

pipelineId=$1

curl -H "apikey:$apikey" "$url"/pipelines/$pipelineId?format=boutiques
