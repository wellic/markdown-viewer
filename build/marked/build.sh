#!/bin/bash

# set current working directory to directory of the shell script
cd "$(dirname "$0")"

curl https://cdnjs.cloudflare.com/ajax/libs/marked/4.1.1/marked.min.js --output ../../vendor/marked.min.js
