#!/bin/sh
#ANSIBLE_HOST_KEY_CHECKING=False
~/cloudmesh.kubernetes/scripts/create-cluster.sh
~/cloudmesh.kubernetes/scripts/hosts-setup.sh
ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/chameleon/kubernetes.yml -i inventory.txt
