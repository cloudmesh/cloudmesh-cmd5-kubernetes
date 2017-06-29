#!/bin/sh
value=`cat /home/hostname/hostName.txt`
grep -n $value /home/hostname/inventory.txt | awk -F \" '{print $2}' >> finalIP # add ips to known_hosts
