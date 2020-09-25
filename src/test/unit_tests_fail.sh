load '../test_helper/bats-support/load'
load '../test_helper/bats-assert/load'

@test "Should return an error & exit status 1- Broken file" {
  run ./mdb_converter.sh SOGNO_Waterford_broken
  assert_output --partial "sogno_waterford_broken removed, exiting..."
  assert_failure 1
}

@test "Should return error message & exit status 1 - File not found" {
  run rm -f ../mdb_files/SOGNO_Waterford_broken.mdb
  sleep 1
  run ./mdb_converter.sh SOGNO_Waterford_broken
  assert_output --partial "SOGNO_Waterford_broken.mdb not found, exiting..."
  assert_failure 1
}
