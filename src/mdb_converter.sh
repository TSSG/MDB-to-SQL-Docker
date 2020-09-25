#!/usr/bin/env bash

FILE=$1
DBMS=postgres

# Check that the mdb file specified exists
if [ ! -f ../mdb_files/$FILE.mdb ]; then
  echo "$1.mdb not found, exiting..."
  exit 1
else
  MDB=../mdb_files/$FILE.mdb
  MdbBASE=`basename ${MDB} .mdb`
  lMdbBASE=`basename ${MDB} .mdb | tr 'A-Z' 'a-z'`
  echo "Processing ${MdbBASE}..."
  if [ ! -d ${lMdbBASE} ]; then
      mkdir -p ${lMdbBASE}
  fi
  echo "Creating database ${lMdbBASE}..."
  # Create a database named for the filename
  createdb ${lMdbBASE}
  echo "Database ${lMdbBASE} created"
  # Export the schema
  mdb-schema --no-relations --no-indexes ${MDB} ${DBMS} | psql -q -d ${lMdbBASE}
  # If there is a problem with the file
  if [ ${PIPESTATUS[0]} -eq 1 ]; then
    echo "Removing database ${lMdbBASE}"
    # Drop the created database
    psql -U postgres -c "drop database ${lMdbBASE}"
    echo "${lMdbBASE} removed, exiting..."
    exit 1
  fi
  # Create the tables and populate them with data
  for T in $(mdb-tables ${MDB})
  do
      echo "Populating table ${T}..."
      mdb-export ${MDB} ${T} > ${lMdbBASE}/${T}.csv
      mdb-export -q "'" -I ${DBMS} ${MDB} ${T} | psql -q -d ${lMdbBASE}
  done
  echo "Completed populating all tables"
  echo "Finished processing ${MdbBASE}.mdb"
fi
