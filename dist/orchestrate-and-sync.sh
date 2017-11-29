#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

spacetime-orchestrator run

for modulestep in $(cat $DIR/datasets.json | jq -r '.[] | .[0] + "." + .[1]'); do
  spacetime-data-package $modulestep
  /root/spacetime/dataset-scripts/dataset-to-s3.sh $modulestep
done

/root/spacetime/dataset-scripts/all-etl-data-to-s3.sh
