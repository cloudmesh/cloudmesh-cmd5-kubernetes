#!/bin/sh
value=`cat /home/files/hostName.txt`
grep -n $value /home/files/inventory.txt | awk -F \" '{print $2}' >> /home/files/finalIP # add ips to known_hosts
