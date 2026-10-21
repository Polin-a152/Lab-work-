#!/bin/bash

TEST_DIR="./log"
FILE_COUNT=10
SIZE="10k"

echo "Creating a text folder: $TEST_DIR"

mkdir -p "$TEST_DIR"

for ((i=1; i<=FILE_COUNT; i++)); do
    FILENAME="$TEST_DIR/log_$(printf "%02d" $i).log"
    head -c 100k /dev/urandom | base64 > "$FILENAME"
    MINUTES_AGO=$(( i * 10 ))
    touch -d "$MINUTES_AGO minutes ago" "$FILENAME"
    
    echo "Created: $FILENAME (changed $MINUTES_AGO minute ago)"
done

echo "Done! Created $FILE_COUNT files in the folder $TEST_DIR"
