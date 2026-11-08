#!/bin/bash
set -euo pipefail

bucket="$1"
directory="$2"

mkdir -p "$directory"
aws s3 cp "s3://$bucket/" "$directory" --recursive --exclude "*" --include "*.txt"

absolute_path=$(realpath -s "$directory")
echo "File path" > book_list.txt
find "$absolute_path" -name "*.txt" | sort >> book_list.txt
count=$(tail -n +2 book_list.txt | wc -l)
echo "Wrote $count book files to book_list.txt"
