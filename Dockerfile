FROM mhart/alpine-node:8

# Set AWS and Digital Collections credentials
ARG DIGITAL_COLLECTIONS_TOKEN
ENV DIGITAL_COLLECTIONS_TOKEN=${DIGITAL_COLLECTIONS_TOKEN}

ARG AWS_ACCESS_KEY_ID
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}

ARG AWS_SECRET_ACCESS_KEY
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

RUN apk update

# Install bash, bash, zip, nano and jq
RUN apk add bash && apk add git && apk add zip && apk add nano && apk add jq

# make, gcc and python are needed for node-gyp to work
RUN apk add make gcc g++ python

# Install aws-cli
RUN apk add py-pip
RUN pip install --upgrade pip
RUN pip install awscli

# Install GDAL
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk update
RUN apk add gdal

# Create directories
RUN mkdir /root/spacetime
RUN mkdir /root/spacetime/etl-modules
RUN mkdir -p /root/data/spacetime/etl

# Install CLI tools
WORKDIR /root/spacetime/
RUN npm install -g nypl-spacetime/spacetime-etl
RUN npm install -g nypl-spacetime/spacetime-cli
RUN npm install -g nypl-spacetime/spacetime-config
RUN npm install -g nypl-spacetime/orchestrator
RUN npm install -g nypl-spacetime/data-package

# Install city-directory-entry-parser
#   this tool needs Python 3, and several math + ML modules
RUN git clone https://github.com/nypl-spacetime/city-directory-entry-parser.git
RUN apk add python3 python3-dev openblas-dev py3-pip
RUN pip3 install numpy scipy sklearn nltk sklearn_crfsuite

# Get dataset scripts
RUN git clone https://github.com/nypl-spacetime/dataset-scripts.git

# Create configuration file
COPY dist/spacetime.docker.config.yml /root/spacetime/
ENV SPACETIME_CONFIG=/root/spacetime/spacetime.docker.config.yml

# Populate /etc/mime.types
#   Used by AWS CLI when syncing files to S3
#   https://docs.python.org/2/library/mimetypes.html
COPY dist/mime.types /etc/

# Install ETL Modules
COPY dist/datasets.json /root/spacetime/
COPY dist/install-etl-modules.sh /root/spacetime/
COPY dist/update-etl-modules.sh /root/spacetime/
RUN /root/spacetime/install-etl-modules.sh

# Create AWS credentials file
RUN mkdir /root/.aws
COPY dist/aws-credentials.sh /root/spacetime/
RUN /root/spacetime/aws-credentials.sh > /root/.aws/credentials

# Copy orchestrate and sync script
COPY dist/orchestrate-and-sync.sh /root/spacetime

# Clean up apk cache when done.
RUN rm -rf /var/cache/apk/*

WORKDIR /root/spacetime/

ENTRYPOINT ["./orchestrate-and-sync.sh"]
