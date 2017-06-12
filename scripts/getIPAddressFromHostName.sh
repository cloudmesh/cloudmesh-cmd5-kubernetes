#!/bin/sh
# My first Script
while IFS= read -r line;do
    cm vm list | grep "$line" | awk '{print $9 }' >> ipAddress.txt
done < "hostName.txt"

