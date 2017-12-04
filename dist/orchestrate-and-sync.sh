#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Pull latest version of ETL modules from GitHub
# This is useful when testing, maybe should be disabled later
/root/spacetime/update-etl-modules.sh

spacetime-orchestrator run

for modulestep in $(cat $DIR/datasets.json | jq -r '.[] | .[0] + "." + .[1]'); do
  # Not all ETL modules produce datasets that produce NYC Space/Time Directory Datasets
  #   If they don't creating a Data Package will fail, so ignore errors on next line
  spacetime-data-package $modulestep || true

  /root/spacetime/dataset-scripts/dataset-to-s3.sh $modulestep
done

/root/spacetime/dataset-scripts/all-etl-data-to-s3.sh
