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
virtualenv ~/ENV2
```

Activate the virtual environment:

```
source ~/ENV/bin/activate
```
  
Now you need to get two source directories. We assume yo place them in ~/ i.e Your home directory:
```
cd ~
git clone https://github.com/cloudmesh/cloudmesh.common.git

```

```
cd ~



git clone https://github.com/cloudmesh/cloudmesh.cmd5.git 

git clone https://github.com/cloudmesh/cloudmesh.kubernetes.git

```
The cmd5 repository contains the shell, while the cloudmesh.Kubernetes directory contains the Kubernetes commands.

```
To install them simply to the following:

cd ~/cloudmesh.common 
python setup.py install; pip install -e .

cd ~/cloudmesh.cmd5 
python setup.py install; pip install -e .

cd ~/github/cloudmesh.kubernetes 
python setup.py install; pip install -e
```
