#!/bin/sh
cm cluster nodes cluster-001|awk '{print $2 }'> ip_list
sed -i 's/$/ ansible_ssh_user=cc/' ip_list
sed -i 's/$/ ansible_ssh_private_key="\/home\/sagar\/.ssh\/id_rsa.pem"/' ip_list
echo [kubernetes]|cat > inventory
head -n2 -q ip_list | tail -n1 >> inventory 
rm ip_list
