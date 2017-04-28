#!/bin/sh
#ANSIBLE_HOST_KEY_CHECKING=False
~/cloudmesh.kubernetes/scripts_chameleon/create-cluster.sh
~/cloudmesh.kubernetes/scripts_chameleon/hosts-setup.sh
ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/chameleon/kubernetes.yml -i ~/cloudmesh.kubernetes/ansiblescript/chameleon/inventory.txt
ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/chameleon/master.yml -i ~/cloudmesh.kubernetes/ansiblescript/chameleon/inventory.txt
sh ~/cloudmesh.kubernetes/scripts_chameleon/join-slaves.sh
