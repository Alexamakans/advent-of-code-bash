#!/usr/bin/env bash

SCRIPT_ROOT=$(pwd)
INPUT_DIR=$SCRIPT_ROOT/inputs
SOURCE_DIR=$SCRIPT_ROOT/src

if [[ $# -ne 1 ]]; then
  echo "Expected 1 or 2 arguments"
  echo "$0 <DAY>"
  echo "$0 test <DAY>"
  exit 1
fi

DAY=$1

SESSION_NAME="AdventOfCode2024"
CMD_NVIM="nvim $SCRIPT_ROOT/src/${DAY}.bash"
CMD_WATCH_TEST="$SCRIPT_ROOT/watch.bash test $1"
CMD_WATCH="$SCRIPT_ROOT/watch.bash $1"

tmux has-session -t "$SESSION_NAME" 2>/dev/null
if [ $? != 0 ]; then
  tmux new-session -d -s "$SESSION_NAME"

  tmux split-window -h -t "$SESSION_NAME"
  tmux send-keys -t "$SESSION_NAME:0.1" "$CMD_WATCH_TEST" C-m

  tmux split-window -v -t "$SESSION_NAME:0.1"
  tmux send-keys -t "$SESSION_NAME:0.2" "$CMD_WATCH" C-m

  tmux select-pane -t "$SESSION_NAME:0.0"
  tmux send-keys -t "$SESSION_NAME:0.0" "$CMD_NVIM" C-m
fi

tmux attach -t "$SESSION_NAME"
