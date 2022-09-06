#!/usr/bin/env bats

setup() {
    bats_load_library bats-support.load.bash
    bats_load_library bats-assert.load.bash 
}

@test "Cannot run script" {
   refute nonstdlib.sh
}

@test "Can source script" {
  # We cannot source in a bats test, so instead run a shell that sources the file
  bash -c 'source nonstdlib.sh'
}

@test "Test success value" {
    run bash -c 'source nonstdlib.sh && echo $SUCCESS'
    # check partial output since there is a newline at the end
    assert_output --partial '0'
}

@test "Test error value" {
    run bash -c 'source nonstdlib.sh && echo $FAILURE'
    # check partial output since there is a newline at the end
    assert_output --partial 1
}

@test "Test usage error value" {
    run bash -c 'source nonstdlib.sh && echo $USAGE_ERROR'
    # check partial output since there is a newline at the end
    assert_output --partial 2
}

