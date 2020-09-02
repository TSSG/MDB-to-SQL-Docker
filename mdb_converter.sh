#!/usr/bin/env bash

DBMS=postgres

for MDB in ./mdb_files/*.mdb;
do
    MdbBASE=`basename ${MDB} .mdb`
    lMdbBASE=`basename ${MDB} .mdb | tr 'A-Z' 'a-z'`
    echo "Processing ${MdbBASE}"
    if [ ! -d ${lMdbBASE} ]; then
        mkdir -p ${lMdbBASE}
    fi
    createdb ${lMdbBASE}
    mdb-schema --no-relations --no-indexes ${MDB} ${DBMS} | psql -q -d ${lMdbBASE}
    for T in $(mdb-tables ${MDB})
    do
        mdb-export ${MDB} ${T} > ${lMdbBASE}/${T}.csv
        mdb-export -q "'" -I ${DBMS} ${MDB} ${T} | psql -q -d ${lMdbBASE}
    done
    echo "Finished processing ${MdbBASE}"
done

echo "Finished processing all files..."
