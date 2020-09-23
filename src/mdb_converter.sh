#!/usr/bin/env bash

DBMS=postgres
DIR=../mdb_files/
# Assign count of .mdb files in DIR
MDBCOUNT=`ls -1 $DIR*.mdb 2>/dev/null | wc -l`

# Check that the mdb_files folder is not empty
if [ $MDBCOUNT -eq 0 ]; then
  echo "No mdb files in mdb_files directory, exiting..."
  exit 1
else
  # For each .mdb file...
  for MDB in $DIR*.mdb;
  do
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
      if [ ${PIPESTATUS[0]} -eq 1 ]; then
        echo "Removing database ${lMdbBASE}"
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
      echo "Finished processing ${MdbBASE}"
  done

  echo "Finished processing all .mdb files"
fi
