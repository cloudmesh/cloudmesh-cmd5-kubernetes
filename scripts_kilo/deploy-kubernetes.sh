#!/bin/sh
#ANSIBLE_HOST_KEY_CHECKING=False
~/cloudmesh.kubernetes/scripts_kilo/create-cluster.sh
~/cloudmesh.kubernetes/scripts_kilo/hosts-setup.sh
ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/kilo/kubernetes.yml -i ~/cloudmesh.kubernetes/ansiblescript/kilo/inventory.txt
#ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/kilo/master.yml -i ~/cloudmesh.kubernetes/ansiblescript/kilo/inventory.txt
#sh ~/cloudmesh.kubernetes/scripts_kilo/join-slaves.sh
