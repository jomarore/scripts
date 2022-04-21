#!/bin/bash
# Created by Jose Rojas
# Date 2018-02-15
# Download SFTP and Classify Files.sh


HOST=sftp.jomarore.jm
PORT=6125
USER=your-username
PASSWORD=your-password
MONTH=$(date +%m)
ANO=$(date +%Y)
PREVMONTH=$(date --date "yesterday" +%m)
PREVDAY=$(date --date "yesterday" +%d)
LOCALFOLDER=/Files/Path
FOLDERS="DX1 DB2 DP1 DX5 DPC DY1 DZ4 PBX DZ8 DIR 1DB 2XY DY1 ZBX D2S D5Y 4DY"

sshpass -p ${PASSWORD} sftp -oPort=${PORT} ${USER}@${HOST}:/Remote-Path << CMD
cd LOCALFOLDER_Name/
lcd $LOCALLOCALFOLDER
mget *
bye
CMD

if [ ! -d $LOCALFOLDER/$ANO ];
then
        mkdir $LOCALFOLDER/$ANO
fi

for i in $FOLDERS
do
        if [ -d $LOCALFOLDER/$ANO/$i/$MONTH ]; then
                mv $LOCALFOLDER/0$i$MONTH* $LOCALFOLDER/$ANO/$i/$MONTH
        elif [ "$PREVDAY" -eq "30" -o "$PREVDAY" -eq "31" ]; then
                mv $LOCALFOLDER/0$i$PREVMONTH$PREVDAY* $LOCALFOLDER/$ANO/$i/$PREVMONTH
        elif [ "$MONTH" -eq "03" ] && [ "$PREVDAY" -eq "28" -o "$PREVDAY" -eq "29" ]; then
                mv $LOCALFOLDER/0$i$PREVMONTH$PREVDAY* $LOCALFOLDER/$ANO/$i/$PREVMONTH
        else
                mkdir -p $LOCALFOLDER/$ANO/$i/$MONTH && mv $LOCALFOLDER/0$i$MONTH* $LOCALFOLDER/$ANO/$i/$MONTH
        fi
done

rm -f $LOCALFOLDER/*0D*