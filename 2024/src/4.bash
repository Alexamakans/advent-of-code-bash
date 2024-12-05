#!/usr/bin/env bash

echo "Day 4"

declare -i width=0
declare -a grid=()
while IFS= read -r line; do
  width=${#line}
  while read -n1 c; do
    grid+=($c)
  done <<< $line
done <<< $INPUT

declare -i grid_size=${#grid[@]}
if [ "$((width * width))" -ne $grid_size ]; then
  echo "grid is not square, not supported"
  exit 1
fi

function search() {
  declare -i dx=$1
  declare -i dy=$2
  local needle=$3
  declare -i search_length=${#needle}
  declare -i start=$4

  declare -i sx=$((start % width))
  declare -i sy=$((start / width))

  local i=0

  for ((i = 1; i <= search_length; i++)); do
    local x=$((sx + dx * i))
    local y=$((sy + dy * i))
    ([ $x -lt $width ] && [ $y -lt $width ] && [ $x -ge 0 ] && [ $y -ge 0 ]) || return
    declare -i index=$(( x + y * width))
    local c=${grid[$index]}
    [ "$c" == "${needle:$i-1:1}" ] || return
  done
  true
}

declare -i count=0
for ((i = 0; i < grid_size; i++)); do
  if [ "${grid[$i]}" != 'X' ]; then
    continue
  fi
  # right
  if search 1 0 'MAS' $i; then
    count+=1
  fi
  # left
  if search -1 0 'MAS' $i; then
    count+=1
  fi
  # down
  if search 0 1 'MAS' $i; then
    count+=1
  fi
  # up
  if search 0 -1 'MAS' $i; then
    count+=1
  fi
  # down right
  if search 1 1 'MAS' $i; then
    count+=1
  fi
  # down left
  if search -1 1 'MAS' $i; then
    count+=1
  fi
  # up right
  if search 1 -1 'MAS' $i; then
    count+=1
  fi
  # up left
  if search -1 -1 'MAS' $i; then
    count+=1
  fi
done

echo "  Part 1"
echo "    XMASes: $count"

count=0
for ((i = 0; i < grid_size; i++)); do
  if [ "${grid[$i]}" != 'A' ]; then
    continue
  fi

  declare -i cx=$((i % width))
  declare -i cy=$((i / width))

  if [ $cx -lt 1 ] || [ $cx -ge $(( width - 1 )) ] || [ $cy -lt 1 ] || [ $cy -ge $(( width - 1 )) ]; then
    continue
  fi

  declare -i ul=$(( (cx - 1) + (cy - 1) * width ))
  declare -i br=$(( (cx + 1) + (cy + 1) * width ))

  declare -i ur=$(( (cx + 1) + (cy - 1) * width ))
  declare -i bl=$(( (cx - 1) + (cy + 1) * width ))

  if ([ "${grid[$ul]}" = 'S' ] && [ "${grid[$br]}" = 'M' ]) || ([ "${grid[$ul]}" = 'M' ] && [ "${grid[$br]}" = 'S' ]); then
    if ([ "${grid[$ur]}" = 'S' ] && [ "${grid[$bl]}" = 'M' ]) || ([ "${grid[$ur]}" = 'M' ] && [ "${grid[$bl]}" = 'S' ]); then
      count+=1
    fi
  fi

done

echo "  Part 2"
echo "    X-MASes: $count"
