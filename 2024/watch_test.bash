#!/usr/bin/env bash

# Requires `entr` to be installed

SCRIPT_ROOT=`pwd`
DAY=$1

# Run once before watching to make sure the code file has been created.
$SCRIPT_ROOT/run.bash $DAY

ls $SCRIPT_ROOT/run.bash $SCRIPT_ROOT/samples/$DAY $SCRIPT_ROOT/src/${DAY}.bash \
    | entr $SCRIPT_ROOT/run.bash test $DAY
