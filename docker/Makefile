SHELL := /bin/bash

build:
			docker build --rm -f $(CURDIR)/Dockerfile -t mdb_to_sql ..;

deploy:
			./dockerrun.sh;
			docker cp ../mdb_converter.sh mdb_to_sql_converter:/home/ubuntu;
			docker exec -i mdb_to_sql_converter /home/ubuntu/mdb_converter.sh;

destroy:
		docker rm -f mdb_to_sql_converter;

remove:
		docker image rm mdb_to_sql:latest;
		docker image rm ubuntu:20.04;
