#!/bin/sh
# My first Script
value=`cat /home/files/finalIP`
echo -n "curl https://" >> /home/files/fetchOutput.sh
echo -n $value >> /home/files/fetchOutput.sh
echo -n ":10250/containerLogs/default/" >> /home/files/fetchOutput.sh
value1=`cat /home/files/appName.txt`
echo -n $value1 >> /home/files/fetchOutput.sh
echo -n "/spamdetectionapplication2 --insecure > /home/files/output.txt" >> /home/files/fetchOutput.sh

