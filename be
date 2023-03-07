#!/bin/bash

echo "1. Программа выводит имя текущего каталога" 
echo "2. Запрашивает имя файла, если файл не существует, выводит сообщение об ошибке и снова запрашивает имя файла" 
echo "3. Запрашивает дату" 
echo "4. определяет, изменялся ли индексный дескриптор файла после указанной даты" 

echo

echo "Назаров Егор" 

echo

while true; do
  echo "Текущий каталог: $(pwd)"
  
  today=$(date +"%Y-%m-%d")
  echo "Сегодня: $today"
  
  read -p "Введите имя файла: " filename

  while [[ ! -f $filename ]]; do
    echo "$filename не существует"
    read -p "Введите имя файла: " filename
  done


  read -p "Введите дату для проверки изменения индексных дескрипторов (ГГГГ-ММ-ДД): " checkdate

  while [[ ! $checkdate =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; do
    echo "Введите дату в формате ГГГГ-ММ-ДД"
    read -p "Введите дату для проверки изменения индексных дескрипторов (ГГГГ-ММ-ДД): " checkdate
  done

  moddate=$(stat -c %y $filename | cut -d' ' -f1)

  if [[ $moddate > $checkdate ]]; then
    echo "$filename был изменен после $checkdate"
    exit 120
  else
    echo "$filename не был изменен после $checkdate"
  fi

  read -p "Хотите начать сначала? (y/n): " choice

  if [[ $choice == "n" ]]; then
    break
  fi
done

exit 0
