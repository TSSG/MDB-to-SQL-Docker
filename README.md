# MDB to SQL Converter

This is a Docker environment for converting Microsoft Access MDB files to Postgres SQL.

When deployed, any MDB files supplied will be converted into a Postgres database, and will then be accessible from either within the Docker container through psql, port 5432 is exposed, as such the Docker container can be used as a data source for other applications.

This project makes use of [MDB-Tools](https://github.com/brianb/mdbtools)

## Prerequisites

The following must be installed prior to building and running the Docker environment:

- [Docker](https://www.docker.com/)

- [GNU Make](https://www.gnu.org/software/make/)

Before building the Docker environment, make sure to add the .mdb files you wish to convert into the `/input_files` folder.

## Building & Deployment

Navigate to `/docker` and run the following command to build the image:

> make build

When complete, the Docker image should be available, which can be confirmed using:

> docker images

You should see an image named mdb_to_sql.

To run this image, run the below command from the same `/docker` folder:

> make deploy

This will create the docker container and run the conversion script against all files you have added to the `/input_files` folder.

Logs will run for each file, stating they have started and finished. Once all files are processed the message `Finished processing all files...` will be displayed on the terminal window.

## Removing Container and Images

To remove the project container run the command:

> make destroy

To remove the project images:

> make remove
