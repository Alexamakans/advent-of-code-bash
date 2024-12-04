#!/usr/bin/env bash

# Requires `entr` to be installed

SCRIPT_ROOT=`pwd`
DAY=$1

ls $SCRIPT_ROOT/run.bash $SCRIPT_ROOT/inputs/$DAY $SCRIPT_ROOT/src/${DAY}.bash \
    | entr $SCRIPT_ROOT/run.bash $DAY
