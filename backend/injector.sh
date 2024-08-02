#!/bin/bash

wait $!

SQL_QUERY=$(cat < /dev/stdin)


outputDatabase=$(mariadb --defaults-file=/tmp/.my.cnf <<< "$SQL_QUERY" | sed '1d')

echo "$SQL_QUERY"
echo "$outputDatabase"
