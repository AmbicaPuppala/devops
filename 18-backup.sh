#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}
LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

USAGE(){
    echo -e "Usage: $N sh 18-backup.sh $Y <source-dir> <DEST_DIR> <DAYS(optional)> $N"
    exit 1
}
if [ $# -lt 2 ]
then
    USAGE
fi
if [ ! -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR Source directory does not exist"
    exit 1
fi
if [ ! -d $DEST_DIR ]
then
    echo "$DEST_DIR Destination directory does not exist"
    exit 1
fi

mkdir -p $LOGS_FOLDER

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)
echo "Files to backup: $FILES"

if [ -n "$FILES" ]
then
    echo "Files to backup: $FILES"
    ZIP_FILE="$DEST_DIR/backup-$TIMESTAMP.ZIP"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
    if [ -f "$ZIP_FILE" ]
    then
        echo "Backup file created: $ZIP_FILE"
        while read -r filepath
        do
             echo "Deleting file: $filepath"
             rm -rf $filepath
             echo "deleted file: $filepath"

         done <<< $FILES
    else
         echo "Backup file creation failed"
         exit 1
    fi    
 else
    echo "No files older than $DAYS to backup"
fi    