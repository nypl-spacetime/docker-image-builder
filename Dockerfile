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

# # WORKDIR /home/app/spacetime/etl-modules
# # run git clone https://github.com/nypl-spacetime/etl-oldnyc.git
# # run git clone https://github.com/nypl-spacetime/etl-mapwarper.git
# # run git clone https://github.com/nypl-spacetime/etl-nyc-streets.git
# # run git clone https://github.com/nypl-spacetime/etl-nyc-wards.git
# # run git clone https://github.com/nypl-spacetime/etl-cemeteries.git
# # run git clone https://github.com/nypl-spacetime/etl-building-inspector.git
# # run git clone https://github.com/nypl-spacetime/etl-perris-atlas-footprints.git
# # run git clone https://github.com/nypl-spacetime/etl-digital-collections.git
# # run git clone https://github.com/nypl-spacetime/etl-nyc-churches.git
# # run git clone https://github.com/nypl-spacetime/etl-enumeration-districts.git
# # run git clone https://github.com/nypl-spacetime/etl-group-maps.git
# # run git clone https://github.com/nypl-spacetime/etl-spacetime-graph.git
# # run git clone https://github.com/nypl-spacetime/etl-building-inspector-toponyms.git
# # run git clone https://github.com/nypl-spacetime/etl-elasticsearch-ingest.git

# Clean up apk cache when done.
RUN rm -rf /var/cache/apk/*

WORKDIR /root/spacetime/
