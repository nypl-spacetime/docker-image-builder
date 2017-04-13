#!/bin/bash

for module in $(cat etl-modules.json | jq -r '.[]'); do
  cd /root/spacetime/etl-modules
  git clone https://github.com/nypl-spacetime/etl-$module.git
  cd etl-$module
  npm install
done
