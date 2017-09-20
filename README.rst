Documentation
=============
An dynamically extensible CMD5 based command shell called "Kubernetes" for management and scaling of containerized application.
Kubernetes is an open-source platform for automating deployment,  management and scaling of containerized applications across a cluster. Kubernetes helps in faster deployment of applications and scaling them on the fly. Moreover it optimizes the use of hardware by using the resources which are needed. Kubernetes provides container management features like component replication, load-balancing, service-discovery and logging across components. A Kubernetes cluster can be deployed on either physical or virtual machines. We shall
be deploying a kubernetes cluster using kubeadm - the kubernetes command line tool and Minikube which is a lightweight Kubernetes implementation which creates a VM on the local machine and deploys a simple cluster containing only one node.

Requirements
=============
- Python 2.7.13  
- Ubuntu 16.04

Installation from source
========================
Setup a virtual environment with virtualenv.

virtualenv:

```
- virtualenv ~/ENV2
```

Activate the virtual environment:

```
- source ~/ENV/bin/activate
```

Now you need to get two source directories. We assume yo place them in ~/ i.e Your home directory:

```
- cd ~

- git clone https://github.com/cloudmesh/cloudmesh.common.git 

- git clone https://github.com/cloudmesh/cloudmesh.cmd5.git 

- git clone https://github.com/cloudmesh/cloudmesh.kubernetes.git
```

The cmd5 repository contains the shell, while the cloudmesh.Kubernetes directory contains the Kubernetes commands.

```
To install them simply to the following:

- cd ~/cloudmesh.common

- python setup.py install

- pip install -e .

- cd ~/cloudmesh.cmd5

- python setup.py install

- pip install -e .

- cd ~/github/cloudmesh.kubernetes 

- python setup.py install

- pip install -e

```
Running the above commands will successfully install the CMD5 Kubernetes commands which will help in setting up the Kubernetes cluster and perform the benchmark analysis.

Execution
=========

Before executing the Kubernetes application, you must have cloudmesh client installed on the machine and the cloudmesh.yaml file must have valid username and password for connecting the different cloud systems like Kilo, Chameleon etc and the corresponding clouds must be active as well.

Open up the Terminal in the virtual box and enter the following commands:

To run the shell you can activate it with the cms command. cms stands for cloudmesh shell:

$ cms
It will print the banner and enter the shell:

+-------------------------------------------------------+
|   ____ _                 _                     _      |
|  / ___| | ___  _   _  __| |_ __ ___   ___  ___| |__   |
| | |   | |/ _ \| | | |/ _` | '_ ` _ \ / _ \/ __| '_ \  |
| | |___| | (_) | |_| | (_| | | | | | |  __/\__ \ | | | |
|  \____|_|\___/ \__,_|\__,_|_| |_| |_|\___||___/_| |_| |
+-------------------------------------------------------+
|                  Cloudmesh CMD5 Shell                 |
+-------------------------------------------------------+

cms>

To see the list of commands you can say:

cms> help
To see the manuaul page for a specific command, please use:

help COMMANDNAME

Commands for Kubernetes
=======================

The following commands are added as part of the project and available for use via the cloudmesh shell:

docker
swarm
The refresh commands refresh the current status from remote hosts and the list commands pull the data from local.(This is yet to be fully integrated)
