#!/bin/bash

SCRIPT="./task.sh"
PASS=0
FAIL=0

echo "Тесты"
echo

$SCRIPT >/dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Тест 1 +"
    ((PASS++))
else
    echo "Тест 1 -"
    ((FAIL++))
fi

$SCRIPT log abc 5 >/dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Тест 2 +"
    ((PASS++))
else
    echo "Тест 2 -"
    ((FAIL++))
fi

$SCRIPT /blablabla >/dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Тест 3 +"
    ((PASS++))
else
    echo "Тест 3 -"
    ((FAIL++))
fi

$SCRIPT log 99 2 >/tmp/out.txt 2>&1
if [ $? -eq 0 ]; then
    echo "Тест 4 +"
    ((PASS++))
else
    echo "Тест 4 -"
    ((FAIL++))
fi

if grep -q "Заполненность" /tmp/out.txt 2>/dev/null; then
    echo "Тест 5 +"
    ((PASS++))
else
    echo "Тест 5 -"
    ((FAIL++))
fi

echo
echo "Пройдено: $PASS"
echo "Провалено: $FAIL"