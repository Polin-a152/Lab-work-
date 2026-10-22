#!/bin/bash

SCRIPT="./task.sh"
PASS=0
FAIL=0

mkdir -p log

echo "Tests"
echo

$SCRIPT >/dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Test 1 +"
    PASS=$((PASS + 1))
else
    echo "Test 1 -"
    FAIL=$((FAIL + 1))
fi

$SCRIPT log abc 5 >/dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Test 2 +"
    PASS=$((PASS + 1))
else
    echo "Test 2 -"
    FAIL=$((FAIL + 1))
fi

$SCRIPT /blablabla 50 2 >/dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Test 3 +"
    PASS=$((PASS + 1))
else
    echo "Test 3 -"
    FAIL=$((FAIL + 1))
fi

$SCRIPT log 100 2 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Test 4 +"
    PASS=$((PASS + 1))
else
    echo "Test 4 -"
    FAIL=$((FAIL + 1))
fi

$SCRIPT log 50 abc >/dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Test 5 +"
    PASS=$((PASS + 1))
else
    echo "Test 5 -"
    FAIL=$((FAIL + 1))
fi

echo
echo "Passed: $PASS"
echo "failed: $FAIL"
