#/bin/bash
# please put this shell script to the root of each node folder.
# this shell script for remove the docker-es-cluster's containers and networks designed in the one of linux server.
cd docker-es-tribe && docker-compose down && \
cd ../docker-es-data03 && docker-compose down && \
cd ../docker-es-data02 && docker-compose down && \
cd ../docker-es-data01 && docker-compose down && \
cd ../docker-es-master && docker-compose down && \
cd ..
