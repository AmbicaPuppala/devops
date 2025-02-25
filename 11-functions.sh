#!/bin/bash
USERID=$(id -u)
validate() {
    if [ $1 -ne 0 ]
    then
        echo "Installing MYSQL failed"
        exit 1
    else
        echo "Installing MYSQ success"
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
dnf list installed git
if [ $? -eq 0 ]
then
    echo "git is already installed"
else
    dnf install git -y "Installing GIT"
fi