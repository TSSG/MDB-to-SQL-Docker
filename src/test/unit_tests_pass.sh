load '../test_helper/bats-support/load'
load '../test_helper/bats-assert/load'

@test "Should process file and complete successfully - Working file" {
  run ./mdb_converter.sh SOGNO_Waterford
  assert_output --partial "Finished processing SOGNO_Waterford.mdb"
  assert_success
}
