# Copyright Waterford Institute of Technology 2018
# Telecommunications Software and Systems Group (TSSG)
# Author Darren Leniston <dleniston@tssg.org>

load '../test_helper/bats-support/load'
load '../test_helper/bats-assert/load'

@test "Should return an error & exit status 1- Broken file" {
  run ./mdb_converter.sh testdb_broken
  assert_output --partial "testdb_broken removed, exiting..."
  assert_failure 1
}

@test "Should return error message & exit status 1 - File not found" {
  run rm -f ../mdb_files/testdb_broken.mdb
  sleep 1
  run ./mdb_converter.sh testdb_broken
  assert_output --partial "testdb_broken.mdb not found, exiting..."
  assert_failure 1
}
