#!/bin/bash
NUMBER1=$1
if [ $NUMBER1 -gt 100 ]
then
    echo "$NUMBER1 is greater than 100"
else
    echo "$NUMBER1 is less than 100"
fi
