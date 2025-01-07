#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <start_index> <end_index>"
    exit 1
fi

start_index=$1
end_index=$2
file_name="inputFile"

> $file_name
for ((i=start_index; i<=end_index; i++)); do
    echo "$i, $((RANDOM % 1000))" >> $file_name
done

echo "File $file_name generated with entries from $start_index to $end_index."

