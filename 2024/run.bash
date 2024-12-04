#!/usr/bin/env bash

clear

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

if [ ! -f "$INPUT_DIR/$DAY" ] && [ -f "$SCRIPT_ROOT/.env" ]; then
  . $SCRIPT_ROOT/.env
  if [ -z "$AOC_SESSION" ]; then
    echo "AOC_SESSION is not set"
    exit 1
  fi
  curl https://adventofcode.com/2024/day/$DAY/input --cookie "session=$AOC_SESSION" \
    > $INPUT_DIR/$DAY
fi

export INPUT="$(<$INPUT_DIR/$DAY)"

if [ ! -f "$SOURCE_DIR/${DAY}.bash" ]; then
  echo "#!/usr/bin/env bash" > $SOURCE_DIR/${DAY}.bash
  echo "echo 'no code yet'" >> $SOURCE_DIR/${DAY}.bash
  chmod +x $SOURCE_DIR/${DAY}.bash
fi

$SOURCE_DIR/${DAY}.bash
