# Copyright Waterford Institute of Technology 2018
# Telecommunications Software and Systems Group (TSSG)
# Author Darren Leniston <dleniston@tssg.org>

load '../test_helper/bats-support/load'
load '../test_helper/bats-assert/load'

@test "Should process file and complete successfully - Working file" {
  run ./mdb_converter.sh testdb
  assert_output --partial "Finished processing testdb.mdb"
  assert_success
}
