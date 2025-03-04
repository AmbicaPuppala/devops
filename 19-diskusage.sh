#!/bin/bash
DISK_USAGE=$(df -h | grep xfs)
DISK_TRESHHOLD=10
while read -r line
do
    echo $line
    USAGE=$(echo $line | awk '{print $5}' | cut -d "%" -f1)
    if [ $USAGE -gt $DISK_TRESHHOLD ]
    then
        echo "Disk usage is above $DISK_TRESHHOLD"
    fi
done <<< $DISK_USAGE