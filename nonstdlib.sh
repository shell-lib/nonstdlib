#!/usr/bin/env bash

# Define return codes
SUCCESS=0
FAILURE=1
USAGE_ERROR=2

# Define this function first so that we may call it immediatly
function source_guard()
{
  # '-ef' Checks that both files have the same device and inode numbers
  if [[ "${BASH_SOURCE[0]}" -ef "$0" ]]; then
    echo "This script may only be sourced, not ran"
    exit "${USAGE_ERROR}"
  fi
}

# Stop this file from being ran. This file may only be sourced
source_guard


function exec_guard()
{
  # '-ef' Checks that both files have the same device and inode numbers
  if [[ ! "${BASH_SOURCE[0]}" -ef "$0" ]]; then
    echo "This script may only be ran, not sourced"
    return "${USAGE_ERROR}"
  fi
}

