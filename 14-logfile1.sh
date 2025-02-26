#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[34m"
LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"
validate() {
    if [ $1 -ne 0 ]
    then
        echo -e "$2 $R failed"
        exit 1
    else
        echo -e "$2 $G success"
    fi
}
echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME
if [ $USERID -ne 0 ]
then
    echo -e "$N Error : you are not root user"
    exit 1
fi
dnf list installed mysql &>>$LOG_FILE_NAME
if [ $? -eq 0 ]
then
 dnf install mysql -y &>>$LOG_FILE_NAME
 validate $? "Installing MYSQL"
 else
    echo -e "$G mysql is already installed"
fi
dnf list installed httpd &>>$LOG_FILE_NAME
if [ $? -eq 0 ]
then
    echo -e "$N httpd is already installed"
else
    dnf install httpd -y  &>>$LOG_FILE_NAME
    validate $? "Installing httpd"
fi