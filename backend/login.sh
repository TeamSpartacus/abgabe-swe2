#!/usr/bin/env bash

echo "Content-Type: application/json"
echo

arg1=$(echo $QUERY_STRING | cut -d '&' -f1 | cut -d '=' -f2 | sed 's/%40/@/g')
arg2=$(echo "$QUERY_STRING" | cut -d '&' -f2 | cut -d '=' -f2)


Logindata_von_DB=$(mariadb  --defaults-file=/tmp/.my.cnf -e "SELECT uuid FROM user WHERE email = '$arg1' AND passwordhash = '$arg2';" | sed 1d) #$1 admin@admin.admin $2 8ccb096c6ce717e6db5ec5c9b4d22c27c3b5a140d37299a200f0312d9fc37601

echo "$Logindata_von_DB " > /tmp/dataBaseRequestStatus.txt

if [ -z "$Logindata_von_DB" ]; then
    echo "{ \"status\": 401, \"uuid\":\"\"}"
else 
    echo "{ \"status\": 200, \"uuid\":\"$Logindata_von_DB\"}"
fi