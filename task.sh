#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Using: <path to the folder> <limit N%> <number files M>"
    exit 1
fi

LOG_DIR="$1"
N="$2"
M="$3"

if ! [[ "$N" =~ ^[0-9]+$ ]] || ! [[ "$M" =~ ^[0-9]+$ ]]; then
    echo "Error, N and M must be numbers"
    exit 1
fi

if [ ! -d "$LOG_DIR" ]; then
    echo "Error, folder $LOG_DIR does not exist"
    exit 1
fi

USAGE=$(df -P "$LOG_DIR" | awk 'NR==2 {gsub("%","",$5); print $5}')

echo "Way: $LOG_DIR"
echo "Fullness: $USAGE%"

if [ "$USAGE" -gt "$N" ]; then
    echo "Fullness above the threshold $N%"
    mkdir -p ./backup

    FILES=$(find "$LOG_DIR" -maxdepth 1 -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | head -n "$M" | cut -d' ' -f2-)

    if [ -z "$FILES" ]; then
        echo "There are no files for archiving"
        exit 0
    fi

    echo "Files for archiving: "
    echo "$FILES"

    ARCHIVE="./backup/log_archive_$(date +%Y%m%d_%H%M%S).tar.gz"
    echo "$FILES" | tar -czf "$ARCHIVE" -T -

    if [ $? -eq 0 ]; then
        echo "Archiving is complete: $ARCHIVE"
    else
        echo "Archiving error"
        exit 1
    fi
else
    echo "Fullness is below the threshold $N%"
fi

exit 0
