#!/bin/bash
# https://github.com/jomarore/scripts/blob/main/Delete%20oldest%20backups.sh
# https://sysadmiando.blogspot.com/2022/04/script-delete-oldest-backups.html
# https://jomarore.blogspot.com/2022/04/script-delete-oldest-backups.html
# By @jomarore
# Created by Jose Rojas
# Date 2022-04-18

# Path existing.
BackupPath="/home/backups"

# The maximum of backups to keep
# (the oldest backups will be erased)
MaxBackupFolders=8

# Remove the oldest backups
TotalBackupFolders=$(ls -tr $BackupPath | wc -l)
if [ $TotalBackupFolders -gt $MaxBackupFolders ];then
ToDelete=$(( $TotalBackupFolders - $MaxBackupFolders ));
for DeleteFolders in $(ls -tr $BackupPath | head -$ToDelete);
do
rm -rf $BackupPath/$DeleteFolders;
done
fi;