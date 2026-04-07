#!/bin/bash

set -e # stop on error

if [ $# -ne 1 ]; then
  echo "bad usage"
  echo "usage   : " $0 "input-json-file"
  echo "example : " $0 "grep-test-input.json"
  echo "JSON input file example :"
  cat <<EOF
{
	"name" : "execution name",
	"pipelineIdentifier":"GrepTest/2.4",
	"resultsLocation" : "/vip/Home",
	"inputValues" : {
		"file":"/vip/Home/welcome.txt",
		"text":"wonder"
	}
}
EOF
  exit 1
fi

initFile=$1

curl -X POST -d @$initFile -H "Content-Type:application/json;charset=UTF-8" -H "apikey:$apikey" "$url"/executions
echo "" # to have a line feed
