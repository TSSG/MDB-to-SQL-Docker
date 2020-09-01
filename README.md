# MDB to SQL Converter

The MDB to SQL Converter project aims to facilitate the conversion of Microsoft Access MDB files to SQL.

When deployed with supplied MDB files, the project will bring up a Postgres Docker container which will contain a database for each .mdb file processed.

## Prerequisites

## Deployment

Navigate to `/docker` and run the following command to build the image:

> make build

Once the image is built, run:

> make deploy

Finally, when the container has been brought up, run the command:

> make run_script

Logs will run for each file, stating they have started and finished. Once all files are processed the message `Finished processing all files...` will be displayed on the terminal window.

## Removing Container and Images

To remove the project container run the command:

> make destroy

To remove the project images:

> make remove
