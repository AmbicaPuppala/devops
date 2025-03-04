#!/bin/bash
DISK_USAGE=$(df -h | grep xfs)
DISK_TRESHHOLD=5
MSG=""
while read -r line
do
    echo $line
    USAGE=$(echo $line | awk '{print $5}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk '{print $NF}')
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        MSG+="High Disk usage on partition: $PARTITION Usage is: $USAGE \n "
    fi
done <<< $DISK_USAGE
