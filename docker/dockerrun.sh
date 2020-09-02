# !/bin/bash

CONTAINER="mdb_to_sql_converter"

if [ "$(docker ps -q -a -f name=${CONTAINER})" ]; then
  docker rm -f -v ${CONTAINER}
fi

is_det="-d"
docker run \
  --name ${CONTAINER} \
  -p 5432 \
  -v $(pwd)/../input_files/:/home/ubuntu/mdb_files/ \
  ${is_det} -t mdb_to_sql \
