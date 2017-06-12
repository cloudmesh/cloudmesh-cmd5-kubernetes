#!/bin/sh
# My first Script
echo -n "curl https://" >> test_file2.txt
while IFS= read -r line;do
    echo -n "$line" >> test_file2.txt
done < "ipAddress.txt"
echo -n ":10250/containerLogs/default/" >> test_file2.txt
while IFS= read -r line;do
    echo -n "$line" >> test_file2.txt
done < "appName.txt"
echo -n "/spamdetectionapplication1 --insecure > output.txt" >> test_file2.txt

