#!/usr/bin/env bash

# Requires `entr` to be installed

SCRIPT_ROOT=$(pwd)
DAY=$1
RUN_TEST=0
INPUT_DIR=$SCRIPT_ROOT/inputs

if [[ $# -eq 0 ]] || [[ $# -gt 2 ]]; then
  echo "Expected 1 or 2 arguments"
  echo "$0 <DAY>"
  echo "$0 test <DAY>"
  exit 1
fi

if [[ $DAY -eq 'test' ]]; then
  DAY=$2
  INPUT_DIR=$SCRIPT_ROOT/samples
  RUN_TEST=1
fi

# Run once before watching to make sure the code file has been created.
if [ $RUN_TEST = 1 ]; then
  $SCRIPT_ROOT/run.bash test $DAY
  ls $SCRIPT_ROOT/run.bash $INPUT_DIR/$DAY $SCRIPT_ROOT/src/${DAY}.bash |
    entr $SCRIPT_ROOT/run.bash test $DAY
else
  $SCRIPT_ROOT/run.bash $DAY
  ls $SCRIPT_ROOT/run.bash $INPUT_DIR/$DAY $SCRIPT_ROOT/src/${DAY}.bash |
    entr $SCRIPT_ROOT/run.bash $DAY
fi
