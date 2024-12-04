#!/usr/bin/env bash

SCRIPT_ROOT=`pwd`
INPUT_DIR=$SCRIPT_ROOT/inputs
SOURCE_DIR=$SCRIPT_ROOT/src

if [[ $# -eq 0 ]] || [[ $# -gt 2 ]]; then
  echo "Expected 1 or 2 arguments"
  echo "${FILE}.bash <DAY>"
  echo "${FILE}.bash test <DAY>"
  exit 1
fi

DAY=$1
if [[ $DAY -eq 'test' ]]; then
  DAY=$2
  INPUT_DIR=$SCRIPT_ROOT/samples
fi

if [ ! -f $INPUT_DIR/$DAY ] && [ -f $SCRIPT_ROOT/.env ]; then
  . $SCRIPT_ROOT/.env
  curl https://adventofcode.com/2024/day/DAY/input --cookie "session=$SESSION"
fi

export INPUT="$(<$INPUT_DIR/$DAY)"

$SOURCE_DIR/${DAY}.bash
