FROM mhart/alpine-node

RUN apk update

# Install bash, bash and jq
RUN apk add bash && apk add git && apk add jq

# Create Directories
RUN mkdir /root/spacetime
RUN mkdir /root/spacetime/etl-modules
RUN mkdir -p /root/data/spacetime/etl

# Install Orchestrator
WORKDIR /root/spacetime/
RUN npm install -g nypl-spacetime/orchestrator

# Create configuration file
COPY spacetime.docker.config.yml /root/spacetime/
ENV SPACETIME_CONFIG=/root/spacetime/spacetime.docker.config.yml

# Install ETL Modules
COPY etl-modules.json /root/spacetime/
COPY install-etl-modules.sh /root/spacetime/
RUN /root/spacetime/install-etl-modules.sh

# Clean up apk cache when done.
RUN rm -rf /var/cache/apk/*

WORKDIR /root/spacetime/
