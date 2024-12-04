#!/usr/bin/env bash

echo "Day 1 - Part 1"

left=()
right=()

while IFS= read -r line; do
  parts=($line)
  left+=(${parts[0]})
  right+=(${parts[1]})
done < <(echo "$INPUT")

left=($(printf "%s\n" "${left[@]}" | sort))
right=($(printf "%s\n" "${right[@]}" | sort))

total_distance=0
similarity=0

for (( i=0;  i<${#left[@]}; i++ )); do
  distance=$(( ${left[$i]} - ${right[$i]} ))
  if [[ $distance -lt 0 ]]; then
    distance=$(($distance * -1))
  fi
  total_distance=$(( $total_distance + $distance ))

  occurrences=$(echo "${right[@]}" | grep -o ${left[$i]} | wc -l)
  similarity=$(( $similarity + ${left[$i]}*$occurrences ))
done

echo "  Part 1"
echo "    Distance: $total_distance"

echo "  Part 2"
echo "    Similarity: $similarity"
