# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.

FROM phusion/passenger-nodejs:0.9.20

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Create Directories
run mkdir /home/app/spacetime-app
run mkdir /home/app/spacetime-app/etl-modules

# Install ETL Modules
WORKDIR /home/app/spacetime-app/etl-modules
run git clone https://github.com/nypl-spacetime/etl-oldnyc.git
run git clone https://github.com/nypl-spacetime/etl-mapwarper.git
run git clone https://github.com/nypl-spacetime/etl-nyc-streets.git
run git clone https://github.com/nypl-spacetime/etl-nyc-wards.git
run git clone https://github.com/nypl-spacetime/etl-cemeteries.git
run git clone https://github.com/nypl-spacetime/etl-building-inspector.git
run git clone https://github.com/nypl-spacetime/etl-perris-atlas-footprints.git
run git clone https://github.com/nypl-spacetime/etl-digital-collections.git
run git clone https://github.com/nypl-spacetime/etl-nyc-churches.git
run git clone https://github.com/nypl-spacetime/etl-enumeration-districts.git
run git clone https://github.com/nypl-spacetime/etl-group-maps.git
run git clone https://github.com/nypl-spacetime/etl-spacetime-graph.git
run git clone https://github.com/nypl-spacetime/etl-building-inspector-toponyms.git
run git clone https://github.com/nypl-spacetime/etl-elasticsearch-ingest.git

# The 'app' user is who owns this
RUN chown -R app:app /home/app/spacetime-app

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
