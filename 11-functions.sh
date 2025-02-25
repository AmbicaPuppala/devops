#!/bin/bash
USERID=$(id -u)
validate() {
    if [ $1 -ne 0 ]
    then
        echo "$2 failed"
        exit 1
    else
        echo "$2 success"
    fi
}
if [ $USERID -ne 0 ]
then
    echo "Error : you are not root user"
    exit 1
fi
dnf list installed mysql
if [ $? -eq 0 ]
then
 dnf install mysql -y
 validate $? "Installing MYSQL"
 else
    echo "mysql is already installed"
fi
dnf list installed httpd
if [ $? -eq 0 ]
then
    echo "httpd is already installed"
else
    dnf install httpd -y "Installing httpd"
fi