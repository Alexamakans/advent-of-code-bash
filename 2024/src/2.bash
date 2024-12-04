#!/usr/bin/env bash

echo "Day 2"

function part_one() {
  declare -i safes
  safes=0
  while IFS= read -r line; do
    parts=($line)
    direction='NONE'
    for ((i = 0; i < ${#parts[@]} - 1; i++)); do
      declare -i difference
      difference=$((${parts[$i]} - ${parts[$i + 1]}))
      current_direction='NONE'
      if [ $difference -lt 0 ]; then
        current_direction='DOWN'
      elif [ $difference -gt 0 ]; then
        current_direction='UP'
      fi

      if [ $i -eq 0 ]; then
        direction="$current_direction"
      fi

      if [ $current_direction = $direction ]; then
        if [ $difference -lt -3 ] || [ $difference -gt 3 ]; then
          break
        fi

        if [ $i -eq $((${#parts[@]} - 2)) ]; then
          safes+=1
        fi
      else
        break
      fi
    done
  done < <(echo "$INPUT")
  echo "$safes"
}

function part_two() {
  declare -i safes
  safes=0
  while IFS= read -r line; do
    all_parts=($line)
    declare -i num_parts
    num_parts=${#all_parts[@]}
    for ((to_skip = -1; to_skip < $num_parts; to_skip++)); do
      direction='NONE'
      done_with_line=false
      parts=()
      for ((i=0; i < $num_parts; i++)); do
        if [ $i -eq $to_skip ]; then
          continue
        fi
        parts+=(${all_parts[$i]})
      done

      for ((i = 0; i < ${#parts[@]} - 1; i++)); do
        declare -i difference
        difference=$((${parts[$i]} - ${parts[$i + 1]}))
        current_direction='NONE'
        if [ $difference -lt 0 ]; then
          current_direction='DOWN'
        elif [ $difference -gt 0 ]; then
          current_direction='UP'
        else
          # They must always increase or decrease
          break
        fi

        if [ $i -eq 0 ]; then
          direction="$current_direction"
        fi

        if [ $current_direction = $direction ]; then
          if [ $difference -lt -3 ] || [ $difference -gt 3 ]; then
            break
          fi

          if [ $i -eq $((${#parts[@]} - 2)) ]; then
            done_with_line=true
            safes+=1
          fi
        else
          break
        fi
      done
      if [ $done_with_line = true ]; then
        break
      fi
    done
  done < <(echo "$INPUT")
  echo "$safes"
}

echo "  Part 1"
echo "    Safes: $(part_one)"

echo "  Part 2"
echo "    Semi-Safes: $(part_two)"
