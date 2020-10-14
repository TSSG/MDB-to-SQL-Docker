# Copyright Waterford Institute of Technology 2018
# Telecommunications Software and Systems Group (TSSG)
# Author Darren Leniston <dleniston@tssg.org>

SHELL := /bin/bash

build:
			docker build --rm -f $(CURDIR)/Dockerfile -t mdb_to_sql ..;

deploy:
			./dockerrun.sh prod;
			docker cp ../src/mdb_converter.sh mdb_to_sql_converter:/home/ubuntu/src;

convert:
			docker exec -i mdb_to_sql_converter /home/ubuntu/src/mdb_converter.sh $(file)

test_errors:
<<<<<<< HEAD
		./dockerrun.sh test;
		docker cp ../src/mdb_converter.sh mdb_to_sql_converter:/home/ubuntu/src;
		docker cp ../src/test/test_files/testdb_broken.mdb mdb_to_sql_converter:/home/ubuntu/mdb_files
		docker cp ../src/test/unit_tests_fail.sh mdb_to_sql_converter:/home/ubuntu/src;
		docker exec -i mdb_to_sql_converter bats /home/ubuntu/src/unit_tests_fail.sh;

test_pass:
		./dockerrun.sh test;
		docker cp ../src/mdb_converter.sh mdb_to_sql_converter:/home/ubuntu/src;
		docker cp ../src/test/test_files/testdb.mdb mdb_to_sql_converter:/home/ubuntu/mdb_files
		docker cp ../src/test/unit_tests_pass.sh mdb_to_sql_converter:/home/ubuntu/src;
		docker exec -i mdb_to_sql_converter bats /home/ubuntu/src/unit_tests_pass.sh;
=======
			./dockerrun.sh test;
			docker cp ../src/mdb_converter.sh mdb_to_sql_converter:/home/ubuntu/src;
			docker cp ../src/test/test_files/testdb_broken.mdb mdb_to_sql_converter:/home/ubuntu/mdb_files
			docker cp ../src/test/unit_tests_fail.sh mdb_to_sql_converter:/home/ubuntu/src;
			docker exec -i mdb_to_sql_converter bats /home/ubuntu/src/unit_tests_fail.sh;

test_pass:
			./dockerrun.sh test;
			docker cp ../src/mdb_converter.sh mdb_to_sql_converter:/home/ubuntu/src;
			docker cp ../src/test/test_files/testdb.mdb mdb_to_sql_converter:/home/ubuntu/mdb_files
			docker cp ../src/test/unit_tests_pass.sh mdb_to_sql_converter:/home/ubuntu/src;
			docker exec -i mdb_to_sql_converter bats /home/ubuntu/src/unit_tests_pass.sh;
>>>>>>> 308f72c21bff98bcf9a22a14e930ac623c3dd927

destroy:
			docker rm -f mdb_to_sql_converter;

remove:
			docker image rm mdb_to_sql:latest;
			docker image rm ubuntu:20.04;
