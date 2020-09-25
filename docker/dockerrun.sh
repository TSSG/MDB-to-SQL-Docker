# !/bin/bash

CONTAINER="mdb_to_sql_converter"

if [ "$(docker ps -q -a -f name=${CONTAINER})" ]; then
  docker rm -f -v ${CONTAINER}
fi

runtype=$1
typearr=("prod" "test")

if [[ " ${typearr[@]} " =~ " ${runtype} " ]]; then
  # run_cmd = command to be run on container boot
  # is_det = specifiing if container should be detached from terminal or not
  if [ ${runtype} == "test" ]; then
    is_det="-d"

    docker run \
      --name ${CONTAINER} \
      -p 5432 \
      ${is_det} -t mdb_to_sql

  else

    is_det="-d"
    docker run \
      --name ${CONTAINER} \
      -p 5432 \
      -v $(pwd)/../input_files/:/home/ubuntu/mdb_files/ \
      ${is_det} -t mdb_to_sql

  fi
else
  printf "Please make sure to run with 'prod' or 'test' flag only\n"
  printf "Example: ./dockerrun.sh test\n"
fi
