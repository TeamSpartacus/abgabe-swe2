#!/usr/bin/env bash

wait $!

string=$(cat < /dev/stdin)
action=$(echo "$string" | cut -d ';' -f1)

if test "$action" = "add_device"; then
    echo "$string" | while IFS=";" read add_device longname shortname task modelnumber registernumber manufacturer lastmaintenance location; do
    echo "INSERT INTO device (longname,shortname,task,modelnumber,registernumber,manufacturer,lastmaintenance,location) VALUES
    ('$longname','$shortname','$task','$modelnumber','$registernumber','$manufacturer','$lastmaintenance','$location')"; done

elif test "$action" = "reserve_device"; then
    echo "$string" | while IFS=";" read reserve_device uid location StartDate EndDate uuid; do
    day1=$(echo "$StartDate" | cut -d '.' -f1)
    month1=$(echo "$StartDate" | cut -d '.' -f2)
    year1=$(echo "$StartDate" | cut -d '.' -f3)
    day2=$(echo "$EndDate" | cut -d '.' -f1)
    month2=$(echo "$EndDate" | cut -d '.' -f2)
    year2=$(echo "$EndDate" | cut -d '.' -f3)
    echo "UPDATE device SET user = '$uuid', location = '$location',registerDateStart = '$year1-$month1-$day1 00:00:00', registerDateEnd = '$year2-$month2-$day2 23:59:59', device_Status = 1 WHERE uid = $uid"; done


elif test "$action" = "get_device_status"; then
    echo "$string" | while IFS=";" read  get_device_status uid; do
    echo "SELECT deviceStatus FROM device WHERE uid = $uid"; done

elif test "$action" = "show_device"; then
    echo "$string" | while IFS=";" read show_device uid; do
    echo "SELECT CONCAT_WS(';',uid,longname,shortname,task,modelnumber,registernumber,manufacturer,lastmaintenance,location,user,created_at,updated_at,deviceStatus,registerDateStart,registerDateEnd) from device WHERE UID = $uid"; done

elif test "$action" = "show_allDevice"; then
    echo "$string" | while IFS=";" read show_allDevice; do
    echo "SELECT CONCAT_WS(';',uid,longname,shortname,task,modelnumber,registernumber,manufacturer,lastmaintenance,location,user,created_at,updated_at,deviceStatus,registerDateStart,registerDateEnd) from device"; done

elif test "$action" = "show_alluser"; then
    echo "$string" | while IFS=";" read show_alluser; do
    echo "SELECT CONCAT_WS(';',uuid,name,secondname,occupation,permissions,passwordhash,email) from user"; done

elif test "$action" = "create_user"; then
    echo "$string" | while IFS=";" read create_user email display_name name secondname occupation permissins passwordhash; do
    echo "INSERT INTO user (email,display_name,name,secondname,occupation,permissions,passwordhash) VALUES
    ('$email','$display_name','$name','$secondname','$occupation',$permissins,'$passwordhash')"; done

elif test "$action" = "delete_user"; then
    echo "$string" | while IFS=";" read delete_user uuid; do
    echo "DELETE from user where uuid = $uuid"; done
fi
