#!/bin/sh
#ANSIBLE_HOST_KEY_CHECKING=False
~/cloudmesh.kubernetes/scripts/create-cluster.sh
~/cloudmesh.kubernetes/scripts/hosts-setup.sh
ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/chameleon/kubernetes.yml -i ~/cloudmesh.kubernetes/ansiblescript/chameleon/inventory.txt
ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/chameleon/master.yml -i ~/cloudmesh.kubernetes/ansiblescript/chameleon/inventory.txt
sh ~/cloudmesh.kubernetes/scripts/join-slaves.sh
