#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Использование: <путь к папке> <порог N%> <количество файлов M>"
    exit 1
fi

LOG_DIR="$1"
N="$2"
M="$3"

if ! [[ "$N" =~ ^[0-9]+$ ]] || ! [[ "$M" =~ ^[0-9]+$ ]]; then
    echo "Ошибка, N и M должны быть числами"
    exit 1
fi

if [ ! -d "$LOG_DIR" ]; then
    echo "Ошибка, папка $LOG_DIR не существует"
    exit 1
fi

USAGE=$(df -P "$LOG_DIR" | awk 'NR==2 {gsub("%","",$5); print $5}')

echo "Путь: $LOG_DIR"
echo "Заполненность: $USAGE%"

if [ "$USAGE" -gt "$N" ]; then
    echo "Заполненность выше порога $N%"
    mkdir -p ./backup

    FILES=$(find "$LOG_DIR" -maxdepth 1 -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | head -n "$M" | cut -d' ' -f2-)

    if [ -z "$FILES" ]; then
        echo "Нет файлов для архивации"
        exit 0
    fi

    echo "Файлы для архивации: "
    echo "$FILES"

    ARCHIVE="./backup/log_archive_$(date +%Y%m%d_%H%M%S).tar.gz"
    echo "$FILES" | tar -czf "$ARCHIVE" -T -

    if [ $? -eq 0 ]; then
        echo "Архивация завершена: $ARCHIVE"
    else
        echo "Ошибка при архивации"
        exit 1
    fi
else
    echo "Заполненность ниже порога $N%"
fi

exit 0