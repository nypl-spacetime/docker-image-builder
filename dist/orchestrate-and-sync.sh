#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

spacetime-orchestrator run

for modulestep in $(cat $DIR/datasets.json | jq -r '.[] | .[0] + "." + .[1]'); do
  /root/spacetime/scripts/dataset-to-s3.sh $modulestep
done

/root/spacetime/scripts/all-etl-to-s3.sh
