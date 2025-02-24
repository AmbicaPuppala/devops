#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
    echo "Error : you are not root user"
    exit 1
fi
dnf list installed mysql
if [ $? -eq 0 ]
then
    echo "mysql is already installed"
else
    dnf install mysql -y
fi
dnf list installed httpd
if [ $? -eq 0 ]
then
    echo "httpd is already installed"
else
    dnf install httpd -y
fi
