#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[34m"
validate() {
    if [ $1 -ne 0 ]
    then
        echo -e "$2 $R failed"
        exit 1
    else
        echo -e "$2 $G success"
    fi
}
if [ $USERID -ne 0 ]
then
    echo -e "$N Error : you are not root user"
    exit 1
fi
dnf list installed mysql
if [ $? -eq 0 ]
then
 dnf install mysql -y
 validate $? "Installing MYSQL"
 else
    echo -e "$G mysql is already installed"
fi
dnf list installed httpd
if [ $? -eq 0 ]
then
    echo -e "$N httpd is already installed"
else
    dnf install httpd -y 
    validate $? "Installing httpd"
fi