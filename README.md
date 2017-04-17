# NYC Space/Time Directory Docker Image Build

This repository is used to build a Docker image that
is used to:

- Run all [NYC Space/Time Directory ETL modules](https://github.com/nypl-spacetime/spacetime-etl)
- Publish the results of those ETL modules to S3
- Index the results of the [`spacetime-graph` module](https://github.com/nypl-spacetime/etl-spacetime-graph) into Elasticsearch to power the [NYC Space/Time Directory API](https://github.com/nypl-spacetime/spacetime-api) and [Atlas](https://github.com/nypl-spacetime/atlas)

For more information about the NYC Space/Time Directory project, see [spacetime.nypl.org](http://spacetime.nypl.org).

## Configuration

Environment variables:

    DIGITAL_COLLECTIONS_TOKEN
    SPACETIME_AWS_ACCESS_KEY_ID
    SPACETIME_AWS_SECRET_ACCESS_KEY

## Datasets

See [`dist/datasets.json`](dist/datasets.json).

## Building the Docker Image

To build the Docker image, run:

    ./build.sh

For building without cache, run:

    ./build.sh --no-cache

To run the latest image:

    ./run-bash

To run the image and execute all ETL steps, run:

    ./run-etl
