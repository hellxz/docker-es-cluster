#/bin/bash
# please put this shell script to the root of each node folder.
# this shell script for stop the docker-es-cluster's containers designed in the one of linux server.
docker stop es-tribe es-data03 es-data02 es-data01 es-master
