#!/bin/bash

exec > /root/spacetime/logs/etl.log
exec 2>&1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

spacetime-orchestrate run

for modulestep in $(cat $DIR/datasets.json | jq -r '.[] | .[0] + "." + .[1]'); do
  /root/spacetime/scripts/to-s3.sh $modulestep
done
