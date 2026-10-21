#!/bin/bash

TEST_DIR="./log"
FILE_COUNT=10
SIZE="10k"

echo "Создание тестовой папки: $TEST_DIR"

mkdir -p "$TEST_DIR"

for ((i=1; i<=FILE_COUNT; i++)); do
    FILENAME="$TEST_DIR/log_$(printf "%02d" $i).log"
    head -c 100k /dev/urandom | base64 > "$FILENAME"
    MINUTES_AGO=$(( i * 10 ))
    touch -d "$MINUTES_AGO minutes ago" "$FILENAME"
    
    echo "Создан: $FILENAME (изменен $MINUTES_AGO минут назад)"
done

echo "Готово! Создано $FILE_COUNT файлов в папке $TEST_DIR"