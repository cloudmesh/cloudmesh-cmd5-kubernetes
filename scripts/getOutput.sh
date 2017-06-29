#!/bin/sh
# My first Script
value=`cat ~/finalIP`
echo -n "curl https://" >> fetchOutput.txt
echo -n $value >> fetchOutput.txt
echo -n ":10250/containerLogs/default/" >> fetchOutput.txt
value1=`cat /home/hostname/appName.txt`
echo -n $value1 >> fetchOutput.txt
echo -n "/spamdetectionapplication2 --insecure > output.txt" >> fetchOutput.txt

