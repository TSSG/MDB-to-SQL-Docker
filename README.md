# MDB to SQL Converter

This is a Docker environment for converting Microsoft Access MDB files to Postgres SQL.

When deployed, any MDB files supplied will be converted into a [Postgres](https://www.postgresql.org/) database, and will then be accessible from either within the Docker container through psql, port 5432 is exposed, as such the Docker container can be used as a data source for other applications.

This project makes use of [MDB-Tools](https://github.com/brianb/mdbtools).

## Prerequisites

The following must be available on your system prior to building and running the Docker environment:

- [Docker](https://www.docker.com/)

- [GNU Make](https://www.gnu.org/software/make/)

## Building & Deployment

Navigate to `/docker` and run the following command to build the image:

> make build

When complete, the Docker image should be available, which can be confirmed using:

> docker images

You should see an image named mdb_to_sql.

To run this image, run the below command from the same `/docker` folder:

> make deploy

This will create a docker container named `mdb_to_sql_converter`, which you should be able to see if you run the command:

> docker ps -a

## Converting Files

Before converting any files, make sure to add them to the `/input_files` folder. As this folder is treated as a volume, you may add additional files later and convert them as you go.

To convert a file, the command `make convert` is used, with a file name supplied (you do not have to add the .mdb extension). An example is shown below for a file named `sample.mdb`:

> make convert file=sample

You will see a number of log entries in the terminal while the conversion is running, but the final two are the most important:

```console
Completed populating all tables
Finished processing sample.mdb
```

Which will let you know that the process has completed.

Within the `mdb_to_sql_converter` container you will now have a Postgres database named `sample` with all your tables and data.

## Running Unit Tests

Testing for this project utilises [BATS](https://github.com/sstephenson/bats)(Bash Automated Testing System) and contains two defined testing streams included, one for testing that a valid mdb file is processed correctly, and another for testing a broken mdb file to ensure it is handled as expected.

The tests can be run from the `/docker` folder using the following commands:

- Testing a valid file:

> test_pass

- Testing an invalid file:

> test_errors

> make test_pass

- Testing an invalid file:

> make test_errors

## Removing Container and Images

To remove the project container run the command:

> make destroy

To remove the project images:

> make remove

Copyright Waterford Institute of Technology 2019-2020, Telecommunications Software and Systems Group (TSSG), Author Darren Leniston dleniston@tssg.org

This work is supported by European Union’s Horizon 2020 research and innovation programme under grant agreement No 774613, project SOGNO (Service Oriented Grid for the Network of the Future)
