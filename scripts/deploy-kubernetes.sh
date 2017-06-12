#!/bin/sh
#ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/kubernetes.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt
ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/master.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt
sh ~/cloudmesh.kubernetes/scripts/join-slaves.sh
ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/runningapplicationonkubernetes.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt
#ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/spamdetectionapp.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt
#sh ~/cloudmesh.kubernetes/scripts/remove-all-clusters.sh
