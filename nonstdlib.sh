#!/usr/bin/env bash

set -x
echo ''
echo "${BASH_SOURCE[@]}"
echo ''


# Define return codes
SUCCESS=0
export SUCCESS
FAILURE=1
export FAILURE
USAGE_ERROR=2
export USAGE_ERROR


# Define this function first so that we may call it immediatly
function source_guard()
{
  # Check bash's call stack for the 


  # '-ef' Checks that both files have the same device and inode numbers
  if [[ "${BASH_SOURCE[-1]}" -ef "$0" ]]; then
    echo "This script may only be sourced, not ran"
    exit "${USAGE_ERROR}"
  fi
}

# Stop this file from being ran. This file may only be sourced
source_guard


function exec_guard()
{
  # '-ef' Checks that both files do not have the same device and inode numbers
  if [[ ! "${BASH_SOURCE[0]}" -ef "$0" ]]; then
    echo "This script may only be ran, not sourced"
    return "${USAGE_ERROR}"
  fi
}

