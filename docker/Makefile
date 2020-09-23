SHELL := /bin/bash

build:
			docker build --rm -f $(CURDIR)/Dockerfile -t mdb_to_sql ..;

deploy:
			./dockerrun.sh prod;
			docker cp ../src/mdb_converter.sh mdb_to_sql_converter:/home/ubuntu/src;
			docker exec -i mdb_to_sql_converter /home/ubuntu/src/mdb_converter.sh;

test_errors:
		./dockerrun.sh test;
		docker cp ../src/mdb_converter.sh mdb_to_sql_converter:/home/ubuntu/src;
		docker cp ../src/test/test_files/SOGNO_Waterford_broken.mdb mdb_to_sql_converter:/home/ubuntu/mdb_files
		docker cp ../src/test/unit_tests_fail.sh mdb_to_sql_converter:/home/ubuntu/src;
		docker exec -i mdb_to_sql_converter bats /home/ubuntu/src/unit_tests_fail.sh;

test_pass:
		./dockerrun.sh test;
		docker cp ../src/mdb_converter.sh mdb_to_sql_converter:/home/ubuntu/src;
		docker cp ../src/test/test_files/SOGNO_Waterford.mdb mdb_to_sql_converter:/home/ubuntu/mdb_files
		docker cp ../src/test/unit_tests_pass.sh mdb_to_sql_converter:/home/ubuntu/src;
		docker exec -i mdb_to_sql_converter bats /home/ubuntu/src/unit_tests_pass.sh;

destroy:
		docker rm -f mdb_to_sql_converter;

remove:
		docker image rm mdb_to_sql:latest;
		docker image rm ubuntu:20.04;
