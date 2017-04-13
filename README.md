# NYC Space/Time Directory Docker Image Build

This repository is used to build the docker image that
is used to:

* Run ETL jobs that aggregate information
* Push the artifacts of those jobs (JSON files) to S3
* Push those JSON documents to Elasticsearch.
    That Elasticsearch powers our public facing sites.

You won't find any ETL logic in this repository.
This repo exists only to build a machine capable of running those jobs.

If you want to learn about the process itself [Bert](https://github.com/bertspaan)
has done a wonderful job with [this README](https://github.com/nypl-spacetime/spacetime-etl) which can serve as a getting started guide.

For more information about the NYC Space/Time Directory project, see [spacetime.nypl.org](http://spacetime.nypl.org).

## Building the Docker Image

_TODO: this will change as we pass build args for secrets, etc_

    docker build --no-cache .

To run the image, with bash:

    docker run --rm -ti IMAGE /bin/bash
