#!/usr/bin/env bash

echo "Day 3"

TRANSFORMED_INPUT="$(echo "$INPUT" | grep -o 'mul([0-9]\+,[0-9]\+)' | tr -d 'mul()' | tr ',' ' ')"

declare -i product=0
while IFS= read -r line; do
  parts=($line)
  declare -i a=${parts[0]}
  declare -i b=${parts[1]}
  product+=$((a * b))
done <<< $TRANSFORMED_INPUT

echo "  Part 1"
echo "    Product: $product"

TRANSFORMED_INPUT="$(echo "$INPUT" | grep -oE "mul\([0-9]+,[0-9]+\)|don't\(\)|do\(\)" | tr -d 'mul()' | tr ',' ' ')"

product=0
active=1
while IFS= read -r line; do
  if [ "$line" = "don't" ]; then
    active=0
  elif [ "$line" = "do" ]; then
    active=1
  fi
  if [ $active -eq 1 ]; then
    parts=($line)
    declare -i a=${parts[0]}
    declare -i b=${parts[1]}
    product+=$((a * b))
  fi
done <<< $TRANSFORMED_INPUT

echo "  Part 2"
echo "    Product: $product"
