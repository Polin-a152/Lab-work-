#!/bin/bash

echo "Hello, world!"

while true; do
    echo "Как тебя зовут ?"
    read name
    if [[ "$name" =~ ^[a-zA-Zа-яА-ЯёЁ]{2,30}$ ]]; then
        break
    else
        echo "Ошибка. Имя только из букв (2-30 символов)"
    fi
done

while true; do
    echo "Сколько тебе лет ?"
    read age
    if [[ "$age" =~ ^[0-9]+$ ]] && [ "$age" -ge 1 ] && [ "$age" -le 120 ]; then
        break
    else
        echo "Ошибка. Возраст должен быть числом от 1 до 120"
    fi
done

echo "Привет, $name, $age лет."