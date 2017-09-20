Cloudmesh Kubernetes
=============
An dynamically extensible CMD5 based command shell called "Kubernetes" for management and scaling of containerized application.
Kubernetes is an open-source platform for automating deployment,  management and scaling of containerized applications across a cluster. Kubernetes helps in faster deployment of applications and scaling them on the fly. Moreover it optimizes the use of hardware by using the resources which are needed. Kubernetes provides container management features like component replication, load-balancing, service-discovery and logging across components. A Kubernetes cluster can be deployed on either physical or virtual machines. We shall
be deploying a kubernetes cluster using kubeadm - the kubernetes command line tool and Minikube which is a lightweight Kubernetes implementation which creates a VM on the local machine and deploys a simple cluster containing only one node.

The repository also includes

- Ansible scripts to install Kubernetes in remote hosts
- Ansible scripts which perform the benchmarking of the Spam Detection application using Docker images on Kubernetes
	
Requirements
------------

* Python 2.7.13
* Ubuntu 16.04
* Cloudmesh Client


Installation from source
------------------------

Setup a virtual environment using virtualenv

virtualenv::

    virtualenv ~/ENV2

Activate the Virtual environment::


     source ~/ENV/bin/activate

Now you need to get two source directories. We assume yo place them in
~/ i.e the home folder::

    
    cd ~/github
    git clone https://github.com/cloudmesh/cloudmesh.common.git
    git clone https://github.com/cloudmesh/cloudmesh.cmd5.git
    git clone https://github.com/cloudmesh/cloudmesh.kubernetes.git

The cmd5 repository contains the shell, while the cloudmesh.kubernetes directory
contains the Kubernetes commands.

To install them simply to the following::

    cd ~/cloudmesh.common
    python setup.py install; pip install -e .
    cd ~/cloudmesh.cmd5
    python setup.py install; pip install -e .
    cd ~/github/cloudmesh.kubernetes
    python setup.py install; pip install -e


Configuration
------------------
Since cloudmesh client is already installed, to get access to a corresponding cloud cluster, you need to have the accurate username and password for each cloud access along with the project name in the cloudmesh.yaml file as shown below.
This file is present in ~/.cloudmesh directory

You will have to do the following modifications to match you machine::

    profile:
        firstname: TBD
        lastname: TBD
        email: TBD
        user: TBD


    active:
        - kilo
	- chameleon
    clouds:
      kilo:    
	credentials:
	  OS_USERNAME: xxxx
          OS_PASSWORD: xxxx
	  OS_PROJECT_NAME: xxxx 
      default:
        flavor: xxxx
        image: xxxx
     chameleon:    
	credentials:
	  OS_USERNAME: xxxx
          OS_PASSWORD: xxxx
	  OS_PROJECT_NAME: xxxx 
    default:
        flavor: xxxx
        image: xxxx

Execution
---------

To run the shell you can activate it with the cms command. cms stands
for cloudmesh shell::

    $ cms

It will print the banner and enter the shell::

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


To see the list of commands you can say::

    cms> help

To see the manula page for a specific command, please use::

    help COMMANDNAME
    
Commands
---------

The following commands are added as part of the project and available
for use via the cloudmesh shell::

    Kubernetes
    
	
The refresh commands refresh the current status from remote hosts and the
list commands pull the data from local.(This is yet to be fully integrated)
    
kubernetes command
--------------

::

          Usage:
            kubernetes name NAME
            kubernetes size SIZE
            kubernetes image IMAGE
            kubernetes flavor FLAVOR
            kubernetes cloud CLOUD
            kubernetes cluster info
            kubernetes cluster deploy
            kubernetes cluster benchmark
           
          Arguments:
            NAME     name of the cluster 
            SIZE     size of the cluster
            IMAGE    image of the instaces in the cluster
            FLAVOR   flavor of the instances in the cluster
            CLOUD    cloud on which the cluster will be created
            

          Options:
            -v       verbose mode

          Description:
            Manages a virtual kubernetes cluster on a cloud



Sample Execution Steps
----------------------

The first step is always to configure the settings required for the Kubernetes cluster.
Here you set the name for the cluster, the size of the cluster, the cloud on which you want to create the Kubernetes cluster and give the cluster an image type. Below are the necessary steps which you need to execute in order to make the Kubernetes cluster work.

Kubernetes name command
-----------------------
::

	cms> kubernetes name xxkubernetes
	Set name to xxkubernetes
The above command sets the name of the Kubernetes cluster to xxkubernetes

Kubernetes size command
-----------------------
::

	cms> kubernetes size 2
	Set size to 2
The above command sets the size of the Kubernetes cluster to 2. So when the cluster will be created, 2 instances will be created in the cluster.

Kubernetes flavor command
-----------------------
::

	cms> kubernetes flavor m1.medium
	Set flavor to m1.medium
The above command sets the flavor of the Kubernetes cluster to m1.medium. There are 3 options for the flavor: m1. small, m1.medium and m1.large. Depending upon the requirements, you may choose the flavor for each instance.

Kubernetes image command
-----------------------
::

	cms> kubernetes image CC-Ubuntu16.04-20160610
	Set image to CC-Ubuntu16.04-20160610
The above command sets the image of the Kubernetes cluster to CC-Ubuntu16.04-20160610. The image has to be a list of all valid images on the corresponding cloud. If you select an incorrect image then it will throw error when the instaces are created.

Kubernetes cloud command
-----------------------
::

	cms> kubernetes cloud chameleon
	Set cloud to chameleon
The above command sets the cloud of the Kubernetes cluster to chameleon. So the cluster will be created on chameleon cloud.

Kubernetes cluster info command
-----------------------
::

	cms> kubernetes cluster info
	Cluster details:
		Cloud  :chameleon
		Name   : xxx
		Size   : 2
		Image  : CC-Ubuntu16.04-20160610
		Flavor : m1.medium
		
	If any of the above details are None/False, please set them using the appropriate command before deploying the cluster
	
The above command lists the info of the mandatory commands needed for the Kubernetes creation. Its gives the cloud name, name of the cluster, Size of the cluster, Image for the cluster and its flavor. Setting each of these commands is necessary before deploying the cluster.

Kubernetes cluster deploy command
-----------------------
Once you have setted all the necessary details or parameters for the Kubernetes cluster, you may deploy the Kubernetes cluster using the Kubernetes deploy command. If any of the cluster details are missing, this won't execute and will ask you to set those details before executing this command.
::

	Creating cluster xxxx...
	Defined cluster xxxx
	set default cloud=chameleon. ok.
	Cluster qwer is now active
	INFO: Booting VM for cluster qwer
	Machine savora-290 is being booted on cloud chameleon ...
	+-----------+--------------------------------+
	| Attribute | Value                          |
	+-----------+--------------------------------+
	| cloud     | chameleon                      |
	| flavor    | m1.medium                      |
	| image     | CC-Ubuntu16.04-20160610        |
	| key       | savora                         |
	| meta      | +                              |
	|   -       | category: chameleon            |
	|   -       | kind: cloudmesh                |
	|   -       | group: default                 |
	|   -       | image: CC-Ubuntu16.04-20160610 |
	|   -       | cluster: xxxx                  |
	|   -       | key: savora                    |
	|   -       | flavor: m1.medium              |
	| name      | savora-290                     |
	| nics      |                                |
	| secgroup  | +                              |
	|   -       | mesos-secgroup                 |
	+-----------+--------------------------------+
	
	.............................................
	..........................................
	.........................................
	
	Cluster xxx created
	qwer
        # 129.114.32.161:22 SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu1
	# 129.114.32.161:22 SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu1
	# 129.114.32.161:22 SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu1
	# 129.114.33.60:22 SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu1
	# 129.114.33.60:22 SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu1
	# 129.114.33.60:22 SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu1
	# 129.114.32.209:22 SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu1
	# 129.114.32.209:22 SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu1
	# 129.114.32.209:22 SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu1
	saving the host file at
	/home/sagar
	Time Taken for creating clusters required for kubernetes:132.914994001 seconds
	
	Running the setup needed for Kubernetes

	PLAY [kubernetes-master kubernetes-slave] **************************************

	TASK [setup] *******************************************************************
	ok: [node3]
	ok: [node1]
	ok: [node2]
	
	............................
	...........................
	...........................
	
	Time Taken for deploying Kubernetes cluster:101.560043097
	Ansible tasks have been successfully completed.
	Cluster qwer created and Kubernetes is running on cluster.
	
The above command creates a Kubernetes cluster with the specified name in the name command with the size in the size command on the cloud mentioned in the cloud command. Moreover, its takes the flavor name and image through the corresponding commands as well. It creates the cluster using cloudmesh client and 

::

	cms docker image list

	+---------+------------------------------------------+------------------------------------------+----------+
	| Ip      | Id                                       | Repository                               | Size(GB) |
	+---------+------------------------------------------+------------------------------------------+----------+
	| docker1 | sha256:909af725a4032bf00f36b45b358c46d6a | elasticsearch:swarm                      | 0.2      |
	|         | 67f8b3201747c8992c920bc34d3148c          |                                          |          |
	| docker1 | sha256:ccec59a7dd849e99addc11a9bd11b15e9 | docker.elastic.co/elasticsearch/elastics | 0.19     |
	|         | addf2dff7741cf82b603d01d0ccdb54          | earch:5.3.0                              |          |
	| docker3 | sha256:ec53e8e805a81d93f3c8d812f3b179f08 | elasticsearch:swarm                      | 0.2      |
	|         | 9695fcfb7d8361ada89588c4da69c82          |                                          |          |
	| docker3 | sha256:ccec59a7dd849e99addc11a9bd11b15e9 | docker.elastic.co/elasticsearch/elastics | 0.19     |
	|         | addf2dff7741cf82b603d01d0ccdb54          | earch:5.3.0                              |          |
	| docker2 | sha256:f70df3612f57225cb85bc20442c42c744 | elasticsearch:swarm                      | 0.2      |
	|         | bf303e3cdcde08c0092c16a8d655748          |                                          |          |
	| docker2 | sha256:ccec59a7dd849e99addc11a9bd11b15e9 | docker.elastic.co/elasticsearch/elastics | 0.19     |
	|         | addf2dff7741cf82b603d01d0ccdb54          | earch:5.3.0                              |          |
	| docker4 | sha256:c66e748329975c1ca97ecc23b2b5fcc02 | elasticsearch:swarm                      | 0.2      |
	|         | f6781885053321add902e9267c42880          |                                          |          |
	| docker4 | sha256:ccec59a7dd849e99addc11a9bd11b15e9 | docker.elastic.co/elasticsearch/elastics | 0.19     |
	|         | addf2dff7741cf82b603d01d0ccdb54          | earch:5.3.0                              |          |
	+---------+------------------------------------------+------------------------------------------+----------+

::

	cms docker container refresh

	+---------+------------------------------------------+-----------------+----------------------+--------+--------------------------------+
	| Ip      | Id                                       | Name            | Image                | Status | StartedAt                      |
	+---------+------------------------------------------+-----------------+----------------------+--------+--------------------------------+
	| docker1 | 31d3cfb389f14f3fbf3ff434584690590c70b37f | /elasticsearch1 | elasticsearch:docker | exited | 2017-04-22T16:47:31.585424378Z |
	|         | c5cd6416db389e49df4d643e                 |                 |                      |        |                                |
	| docker1 | 8a7e6543f9fa1052c05617cbdd4ac87824b402c0 | /elasticsearch2 | elasticsearch:docker | exited | 2017-04-22T16:47:39.25325675Z  |
	|         | 86cd0219b72178d9b75aec0b                 |                 |                      |        |                                |
	| docker2 | 42bd36cfb7a6b44bf423373f5cbbcb11d3a24313 | /elasticsearch4 | elasticsearch:docker | exited | 2017-04-22T16:48:06.191045149Z |
	|         | bcd85565f87f0dcffd9c4122                 |                 |                      |        |                                |
	| docker2 | cb06419167b6d403bd868fca0229637f4cc84fa1 | /elasticsearch3 | elasticsearch:docker | exited | 2017-04-22T16:48:13.076917845Z |
	|         | 6195a7650129038b7e85895b                 |                 |                      |        |                                |
	+---------+------------------------------------------+-----------------+----------------------+--------+--------------------------------+

::

	cms docker container list

	+---------+------------------------------------------+-----------------+----------------------+--------+--------------------------------+
	| Ip      | Id                                       | Name            | Image                | Status | StartedAt                      |
	+---------+------------------------------------------+-----------------+----------------------+--------+--------------------------------+
	| docker1 | 31d3cfb389f14f3fbf3ff434584690590c70b37f | /elasticsearch1 | elasticsearch:docker | exited | 2017-04-22T16:47:31.585424378Z |
	|         | c5cd6416db389e49df4d643e                 |                 |                      |        |                                |
	| docker1 | 8a7e6543f9fa1052c05617cbdd4ac87824b402c0 | /elasticsearch2 | elasticsearch:docker | exited | 2017-04-22T16:47:39.25325675Z  |
	|         | 86cd0219b72178d9b75aec0b                 |                 |                      |        |                                |
	| docker2 | 42bd36cfb7a6b44bf423373f5cbbcb11d3a24313 | /elasticsearch4 | elasticsearch:docker | exited | 2017-04-22T16:48:06.191045149Z |
	|         | bcd85565f87f0dcffd9c4122                 |                 |                      |        |                                |
	| docker2 | cb06419167b6d403bd868fca0229637f4cc84fa1 | /elasticsearch3 | elasticsearch:docker | exited | 2017-04-22T16:48:13.076917845Z |
	|         | 6195a7650129038b7e85895b                 |                 |                      |        |                                |
	+---------+------------------------------------------+-----------------+----------------------+--------+--------------------------------+

::

	cms docker container create test1 elasticsearch:docker
	Container test1 is Created

::

	cms docker container start test1
	Container test1 status changed to start

::

	cms docker container list

	+---------+------------------------------------------+-----------------+----------------------+---------+--------------------------------+
	| Ip      | Id                                       | Name            | Image                | Status  | StartedAt                      |
	+---------+------------------------------------------+-----------------+----------------------+---------+--------------------------------+
	| docker1 | 31d3cfb389f14f3fbf3ff434584690590c70b37f | /elasticsearch1 | elasticsearch:docker | exited  | 2017-04-22T16:47:31.585424378Z |
	|         | c5cd6416db389e49df4d643e                 |                 |                      |         |                                |
	| docker1 | 8a7e6543f9fa1052c05617cbdd4ac87824b402c0 | /elasticsearch2 | elasticsearch:docker | exited  | 2017-04-22T16:47:39.25325675Z  |
	|         | 86cd0219b72178d9b75aec0b                 |                 |                      |         |                                |
	| docker2 | 42bd36cfb7a6b44bf423373f5cbbcb11d3a24313 | /elasticsearch4 | elasticsearch:docker | exited  | 2017-04-22T16:48:06.191045149Z |
	|         | bcd85565f87f0dcffd9c4122                 |                 |                      |         |                                |
	| docker2 | cb06419167b6d403bd868fca0229637f4cc84fa1 | /elasticsearch3 | elasticsearch:docker | exited  | 2017-04-22T16:48:13.076917845Z |
	|         | 6195a7650129038b7e85895b                 |                 |                      |         |                                |
	| docker2 | ad271e34bfb32422b1bc134250daec2941461910 | /test1          | elasticsearch:docker | running | 2017-04-24T11:42:04.659965801Z |
	|         | 933ed3537a4705a26f93a67d                 |                 |                      |         |                                |
	+---------+------------------------------------------+-----------------+----------------------+---------+--------------------------------+

::

	cms docker container stop test1
	Container test1 status changed to stop

::

	cms docker container delete test1
	Container test1 is deleted

::

	cms docker container list

	+---------+------------------------------------------+-----------------+----------------------+--------+--------------------------------+
	| Ip      | Id                                       | Name            | Image                | Status | StartedAt                      |
	+---------+------------------------------------------+-----------------+----------------------+--------+--------------------------------+
	| docker1 | 31d3cfb389f14f3fbf3ff434584690590c70b37f | /elasticsearch1 | elasticsearch:docker | exited | 2017-04-22T16:47:31.585424378Z |
	|         | c5cd6416db389e49df4d643e                 |                 |                      |        |                                |
	| docker1 | 8a7e6543f9fa1052c05617cbdd4ac87824b402c0 | /elasticsearch2 | elasticsearch:docker | exited | 2017-04-22T16:47:39.25325675Z  |
	|         | 86cd0219b72178d9b75aec0b                 |                 |                      |        |                                |
	| docker2 | 42bd36cfb7a6b44bf423373f5cbbcb11d3a24313 | /elasticsearch4 | elasticsearch:docker | exited | 2017-04-22T16:48:06.191045149Z |
	|         | bcd85565f87f0dcffd9c4122                 |                 |                      |        |                                |
	| docker2 | cb06419167b6d403bd868fca0229637f4cc84fa1 | /elasticsearch3 | elasticsearch:docker | exited | 2017-04-22T16:48:13.076917845Z |
	|         | 6195a7650129038b7e85895b                 |                 |                      |        |                                |
	+---------+------------------------------------------+-----------------+----------------------+--------+--------------------------------+

::

	cms docker network refresh

	+---------+------------------------------------------+-----------------+------------+
	| Ip      | Id                                       | Name            | Containers |
	+---------+------------------------------------------+-----------------+------------+
	| docker1 | feb6b33ba133ccb1f72e881e9ac46974f1ea117d | none            | {}         |
	|         | b0b4db39fb087644d55c6342                 |                 |            |
	| docker1 | 4a3311f9f6acf4401461e2e2dc3ddb39c9143bed | host            | {}         |
	|         | 611b20d907b3d899b595e597                 |                 |            |
	| docker1 | 87209b9615716884e2ed8490b59ea805780598a8 | bridge          | {}         |
	|         | 5a18bee6c27ba03aad58f14a                 |                 |            |
	| docker2 | 57bcbb05a76f042e4c07b265d6b4cb2126abdcb6 | host            | {}         |
	|         | 0a07e0e2e173dfacb3d09769                 |                 |            |
	| docker2 | 9f44589db4def03fe5c11e0f560b357909d46528 | bridge          | {}         |
	|         | f02b8ce4161acf58f57202c4                 |                 |            |
	| docker2 | bc39e454661b05050da6b933ee2ec52fbf466caa | none            | {}         |
	|         | 565de287de1941760babbec0                 |                 |            |
	| docker2 | da862dc075bd3458063579675ed2007c65425261 | docker_gwbridge | {}         |
	|         | dd937f49c3231699b86057a3                 |                 |            |
	| docker4 | 92c7eed3ae09c5bf04ee2edcbcd9d8f40c3e52ec | bridge          | {}         |
	|         | d8efd268f7ade74fe2436b74                 |                 |            |
	| docker4 | 3c90bf98d4d991a17db762e07e5f4c3ab9df06f2 | none            | {}         |
	|         | 6f09679144e45236b995a6d3                 |                 |            |
	| docker4 | a134cbac21ea9c7e43d28314266f1aec4c8fcedd | docker_gwbridge | {}         |
	|         | 3ae60ba3041f0d7cc8ff7bbc                 |                 |            |
	| docker4 | c87d97dde5870d21e4f57052d4bd51d7e670d671 | host            | {}         |
	|         | 99a71552f5e5c9514e965e18                 |                 |            |
	| docker3 | 0db9de4744c642ea406aa3b22d2d185b46716e53 | docker_gwbridge | {}         |
	|         | 0c6e5dedbb90be1e4b59236e                 |                 |            |
	| docker3 | 861862abf66bec01af7d4149c91c28d979e1dda7 | host            | {}         |
	|         | 31266eb30bc5c76a7aae551f                 |                 |            |
	| docker3 | 109ed16096d208442f4697b1c25559e99565fd27 | bridge          | {}         |
	|         | 17bd3e5b2285de7513066d62                 |                 |            |
	| docker3 | ceee39512a4de82efdaefb6e6f24d3fc9f73c19e | none            | {}         |
	|         | 88be3886cb2c74f0d9b30e71                 |                 |            |
	+---------+------------------------------------------+-----------------+------------+

::

	cms docker network list

	+---------+------------------------------------------+-----------------+------------+
	| Ip      | Id                                       | Name            | Containers |
	+---------+------------------------------------------+-----------------+------------+
	| docker1 | 4a3311f9f6acf4401461e2e2dc3ddb39c9143bed | host            | {}         |
	|         | 611b20d907b3d899b595e597                 |                 |            |
	| docker3 | 861862abf66bec01af7d4149c91c28d979e1dda7 | host            | {}         |
	|         | 31266eb30bc5c76a7aae551f                 |                 |            |
	| docker3 | ceee39512a4de82efdaefb6e6f24d3fc9f73c19e | none            | {}         |
	|         | 88be3886cb2c74f0d9b30e71                 |                 |            |
	| docker1 | feb6b33ba133ccb1f72e881e9ac46974f1ea117d | none            | {}         |
	|         | b0b4db39fb087644d55c6342                 |                 |            |
	| docker1 | 87209b9615716884e2ed8490b59ea805780598a8 | bridge          | {}         |
	|         | 5a18bee6c27ba03aad58f14a                 |                 |            |
	| docker2 | 57bcbb05a76f042e4c07b265d6b4cb2126abdcb6 | host            | {}         |
	|         | 0a07e0e2e173dfacb3d09769                 |                 |            |
	| docker2 | 9f44589db4def03fe5c11e0f560b357909d46528 | bridge          | {}         |
	|         | f02b8ce4161acf58f57202c4                 |                 |            |
	| docker2 | bc39e454661b05050da6b933ee2ec52fbf466caa | none            | {}         |
	|         | 565de287de1941760babbec0                 |                 |            |
	| docker2 | da862dc075bd3458063579675ed2007c65425261 | docker_gwbridge | {}         |
	|         | dd937f49c3231699b86057a3                 |                 |            |
	| docker4 | 92c7eed3ae09c5bf04ee2edcbcd9d8f40c3e52ec | bridge          | {}         |
	|         | d8efd268f7ade74fe2436b74                 |                 |            |
	| docker4 | 3c90bf98d4d991a17db762e07e5f4c3ab9df06f2 | none            | {}         |
	|         | 6f09679144e45236b995a6d3                 |                 |            |
	| docker4 | a134cbac21ea9c7e43d28314266f1aec4c8fcedd | docker_gwbridge | {}         |
	|         | 3ae60ba3041f0d7cc8ff7bbc                 |                 |            |
	| docker4 | c87d97dde5870d21e4f57052d4bd51d7e670d671 | host            | {}         |
	|         | 99a71552f5e5c9514e965e18                 |                 |            |
	| docker3 | 0db9de4744c642ea406aa3b22d2d185b46716e53 | docker_gwbridge | {}         |
	|         | 0c6e5dedbb90be1e4b59236e                 |                 |            |
	| docker3 | 109ed16096d208442f4697b1c25559e99565fd27 | bridge          | {}         |
	|         | 17bd3e5b2285de7513066d62                 |                 |            |
	+---------+------------------------------------------+-----------------+------------+


Unit Tests
----------

We are providing a simple set of tests that verify the integration of docker
into cloudmesh. They can either be run with `nosetests` .

Use::

  nosetests -v --nocapture tests/test_docker.py
  nosetests -v --nocapture tests/test_swarm.py

to check them out and see if the tests succeed.

Benchmarking
------------

We are providing a set of benchmark scripts that will help you to easily benchmark
the application. They can either be run with cms command .

Use::

  cms docker benchmark N
  cms swarm  benchmark N






