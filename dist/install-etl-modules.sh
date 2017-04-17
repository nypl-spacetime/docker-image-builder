#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for module in $(cat $DIR/datasets.json | jq -r '.[] | .[0]'); do
  cd /root/spacetime/etl-modules
  git clone https://github.com/nypl-spacetime/etl-$module.git
  cd etl-$module
  npm install --only=production
done
