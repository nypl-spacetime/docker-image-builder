#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for module in $(cat $DIR/datasets.json | jq -r '.[] | .[0]'); do
  echo $module
  cd /root/spacetime/etl-modules/etl-$module
  git pull
  npm install --only=production
done
