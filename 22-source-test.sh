#!/bin/bash
source ./22-source-test.sh
echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

FILES_TO_DELETE=$(find $SOURCE_DIR . -name "*.log" -mtime +14)
echo "Files to delete: $FILES_TO_DELETE" 

 while read -r file
 do
  echo "Deleting file: $file"
    rm -rf $file

 done <<< $FILES_TO_DELETE