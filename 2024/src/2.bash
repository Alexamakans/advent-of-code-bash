#!/usr/bin/env bash

SUCCESS=0
FAILED=1

echo "Day 2"

# Function to check if a sequence is "safe"
function is_safe() {
  parts=("$@")
  ascending=$(( ${parts[0]} < ${parts[1]} ))
  descending=$(( ${parts[0]} > ${parts[1]} ))
  if [ $ascending -eq 0 ] && [ $descending -eq 0 ]; then
    return $FAILED
  fi
  for ((i = 0; i < ${#parts[@]} - 1; i++)); do
    difference=$((${parts[i]} - ${parts[i + 1]}))
    if [ $difference -gt 0 ] && [ $ascending -eq 1 ]; then
      return $FAILED
    elif [ $difference -lt 0 ] && [ $ascending -eq 0 ]; then
      return $FAILED
    fi

    if [ $difference -eq 0 ] || [ $difference -lt -3 ] || [ $difference -gt 3 ]; then
      return $FAILED
    fi
  done
  return $SUCCESS
}

function part_one() {
  declare -i safes=0
  while IFS= read -r line; do
    parts=($line)
    if is_safe "${parts[@]}"; then
      safes+=1
    fi
  done <<< "$INPUT"
  echo "$safes"
}

function part_two() {
  declare -i safes=0
  while IFS= read -r line; do
    all_parts=($line)
    num_parts=${#all_parts[@]}
    for ((to_skip = -1; to_skip < num_parts; to_skip++)); do
      parts=()
      for ((i = 0; i < num_parts; i++)); do
        if [ $i -ne $to_skip ]; then
          parts+=("${all_parts[$i]}")
        fi
      done

      if is_safe "${parts[@]}"; then
        safes+=1
        break
      fi
    done
  done <<< "$INPUT"
  echo "$safes"
}

# Main execution
echo "  Part 1"
echo "    Safes: $(part_one)"

echo "  Part 2"
echo "    Semi-Safes: $(part_two)"
