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
dnf list installed git
if [ $? -ne 0 ]
then
    dnf install git -y
then
 echo "Git installed successfully"
 exit 1
fi
