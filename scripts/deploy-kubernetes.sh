#!/bin/sh
#ANSIBLE_HOST_KEY_CHECKING=False
SECONDS=0
echo " The time before deployment"
date
ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/kubernetes.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt
ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/master.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt
sh ~/cloudmesh.kubernetes/scripts/join-slaves.sh
ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/runningapplicationonkubernetes.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt
#ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/spamdetectionapp.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt
#sh ~/cloudmesh.kubernetes/scripts/remove-all-clusters.sh
echo " The time after deployment"
date

