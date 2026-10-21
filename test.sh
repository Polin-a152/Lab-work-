#!/bin/bash

SCRIPT="./task.sh"
PASS=0
FAIL=0

echo "Tests"
echo

$SCRIPT >/dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Test 1 +"
    ((PASS++))
else
    echo "Test 1 -"
    ((FAIL++))
fi

$SCRIPT log abc 5 >/dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Test 2 +"
    ((PASS++))
else
    echo "Test 2 -"
    ((FAIL++))
fi

$SCRIPT /blablabla >/dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Test 3 +"
    ((PASS++))
else
    echo "Test 3 -"
    ((FAIL++))
fi

$SCRIPT log 99 2 >/tmp/out.txt 2>&1
if [ $? -eq 0 ]; then
    echo "Test 4 +"
    ((PASS++))
else
    echo "Test 4 -"
    ((FAIL++))
fi

if grep -q "Fullness" /tmp/out.txt 2>/dev/null; then
    echo "Test 5 +"
    ((PASS++))
else
    echo "Test 5 -"
    ((FAIL++))
fi

echo
echo "Completed: $PASS"
echo "Fail: $FAIL"
