#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
    echo "Error : you are not root user"
    exit 1
fi
dnf list installed mysql