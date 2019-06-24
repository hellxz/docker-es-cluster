#/bin/bash
# please put this shell script to the root of each node folder.
cd docker-es-master && docker-compose up -d && \
cd ../docker-es-data01 && docker-compose up -d && \
cd ../docker-es-data02 && docker-compose up -d && \
cd ../docker-es-data03 && docker-compose up -d && \
cd ../docker-es-tribe && docker-compose up -d && \
cd ..
