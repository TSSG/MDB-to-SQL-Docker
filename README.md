# MDB to SQL Converter

This is a Docker environment for converting Microsoft Access MDB files to Postgres SQL.

When deployed, any MDB files supplied will be converted into a Postgres database, and will then be accessible from either within the Docker container through psql, port 5432 is exposed, as such the Docker container can be used as a data source for other applications.

This project makes use of [MDB-Tools](https://github.com/brianb/mdbtools)

## Prerequisites

The following must be installed prior to building and running the Docker environment:

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

This will create a docker container named `mdb_to_sql_converter`, which you should see be able to see if you run the command:

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

## Removing Container and Images

To remove the project container run the command:

> make destroy

To remove the project images:

> make remove
