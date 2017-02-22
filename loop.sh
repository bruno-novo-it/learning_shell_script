#!/bin/bash

FILE='arq.txt'

total=0
cat $FILE | while read i
do
    total=$((total+1))
done
echo 'Total de linhas: ' $total

total=0
while read i
do
    total=$((total+1))
done < $FILE
echo 'Total de linhas: ' $total

total=0
for i in `cat $FILE`; do
  total=$((total+1))
done
echo 'Total de linhas: ' $total
