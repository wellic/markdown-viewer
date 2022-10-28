#!/bin/bash

# exit if any of the intermediate steps fail
set -e

browser=$1

if [ -z "$browser" ]; then
  echo "Specify target browser"
  echo "chrome, firefox, edge"
  exit 1
fi

# set current working directory to directory of the shell script
cd "$(dirname "$0")"

mkdir -p ../themes
mkdir -p ../vendor

# build deps
sh marked/build.sh
sh mathjax/build.sh
sh mdc/build.sh
sh mermaid/build.sh
sh mithril/build.sh
sh prism/build.sh
sh remark/build.sh
sh themes/build.sh

# archive
mkdir -p tmp
mkdir -p tmp/markdown-viewer
cd ..
cp -r background content icons options popup themes vendor build/tmp/markdown-viewer/

if [ "$browser" = "chrome" ]; then
  cp manifest.json build/tmp/markdown-viewer/
elif [ "$browser" = "firefox" ]; then
  cp manifest.firefox.json build/tmp/markdown-viewer/manifest.json
elif [ "$browser" = "edge" ]; then
  cp manifest.edge.json build/tmp/markdown-viewer/manifest.json
fi

# zip the markdown-viewer folder itself
if [ "$browser" = "chrome" ] || [ "$browser" = "edge" ]; then
  cd build/tmp/
  zip -r ../../markdown-viewer.zip markdown-viewer
  cd ..
# zip the contents of the markdown-viewer folder
elif [ "$browser" = "firefox" ]; then
  cd build/tmp/markdown-viewer/
  zip -r ../../../markdown-viewer.zip .
  cd ../../
fi

rm -rf tmp/