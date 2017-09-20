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

	cms> kubernetes size 3
	Set size to 3
The above command sets the size of the Kubernetes cluster to 3. So when the cluster will be created, 2 instances will be created in the cluster.

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
		Name   : xxxx
		Size   : 3
		Image  : CC-Ubuntu16.04-20160610
		Flavor : m1.medium
		
	If any of the above details are None/False, please set them using the appropriate command before deploying the cluster
	
The above command lists the info of the mandatory commands needed for the Kubernetes creation. Its gives the cloud name, name of the cluster, Size of the cluster, Image for the cluster and its flavor. Setting each of these commands is necessary before deploying the cluster.

Kubernetes cluster deploy command
-----------------------
Once you have setted all the necessary details or parameters for the Kubernetes cluster, you may deploy the Kubernetes cluster using the Kubernetes deploy command. If any of the cluster details are missing, this won't execute and will ask you to set those details before executing this command.
::
	cms> kubernetes cluster deploy
	Creating cluster xxxx...
	Defined cluster xxxx
	set default cloud=chameleon. ok.
	Cluster xxxx is now active
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
	
	Cluster xxxx created
	xxxx
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
	
	Time Taken for installing various pre requites for kubernetes:30.482833147 seconds
	
	Running the setup needed for Kubernetes

	PLAY [kubernetes-master kubernetes-slave] **************************************

	TASK [setup] *******************************************************************
	ok: [node3]
	ok: [node1]
	ok: [node2]
	
	TASK [kubernetes.setup : to install docker for Kubernetes] *********************
	changed: [node1]
 	[WARNING]: Consider using apt module rather than running apt-get
	
	.........................
	.........................
	........................
	
	changed: [node2]
	changed: [node3]
	Time Taken for installing kubernetes related packages:40.039593935 seconds
	
	Installing Kubernetes on master node

	PLAY [kubernetes-master] *******************************************************

	TASK [setup] *******************************************************************
	ok: [node1]

	TASK [initialize_master : to modify the directory permission of the home directory] ***
	changed: [node1]
 	[WARNING]: Consider using file module with mode rather than running chmod
	
	...........................
	...........................
	...........................

	PLAY [kubernetes-master] *******************************************************

	TASK [setup] *******************************************************************
	ok: [node1]
	Time Taken for deploying Kubernetes cluster:101.560043097 seconds
	Ansible tasks have been successfully completed.
	Cluster xxxx created and Kubernetes is running on cluster.
	
The above command creates a Kubernetes cluster with the specified name in the name command with the size in the size command on the cloud mentioned in the cloud command. Moreover, its takes the flavor name and image through the corresponding commands as well. It creates the cluster using cloudmesh client and adds the list of IP address to the known host file and creates a host file for ansible script execution.

After the cluster creation, it triggers various ansible playbooks to configure the Kubernetes cluster. The installations.yml playbook is triggered first which installs git and updates the vms in all the instances. Next up is called the Kubernetes.yml playbook which installs docker for kubernetes, get the kubernetes related packages and installs the dataset required for kubernetes.

Later, its calls the master.yml playbook which installs Kubernetes package on the master (one of the instance) and initializes the kubernetes cluster on it and finally the slaves.yml is called which connects the rest of the instances to this master instance and the creation of Kubernetes cluster is complete.


Kubernetes cluster benchmark command
-----------------------------------
Once the Kubernetes cluster has been deployed, the benchmark command can be executed to perform the benchmark analysis of the spam detection application. This command executes the docker image for the spam detection application and outputs the file which has the time taken for classifying a peice of text as valid email or spam using different algorithms.

::
	cms> kubernetes cluster benchmark
	
	Running the spam detection application

	PLAY [kubernetes-master] *******************************************************

	TASK [setup] *******************************************************************
	ok: [node1]

	TASK [initialize_pods : to make a directory for storing the new created files] *
	changed: [node1]

	TASK [initialize_pods : to modify the directory permission for those files] ****
	changed: [node1]
 	[WARNING]: Consider using 'become', 'become_method', and 'become_user' rather than running sudo


	TASK [initialize_pods : installing daemonset for dns] **************************
	changed: [node1]

	TASK [initialize_pods : run the application using kubectl command] *************
	changed: [node1]

	TASK [initialize_pods : to wait for 5 minutes] *********************************
	Pausing for 300 seconds
	(ctrl+C then 'C' = continue early, ctrl+C then 'A' = abort)
	ok: [node1]

	......................................
	......................................
	.....................................

	

	TASK [initialize_pods : execute the final command which is the curl to the slave node which had executed the application] ***
	changed: [node1]

	TASK [initialize_pods : Fetch Spam Detection output file from the remote and save to local] ***
	changed: [node1]

	PLAY RECAP *********************************************************************
	node1                      : ok=18   changed=16   unreachable=0    failed=0   

	Time Taken for running the Spam Detection application:342.945085049 seconds
	Cluster xxxx created and Kubernetes is running on cluster.
	
The above command runs the spam detection application on the kubernetes cluster and outputs the file which has the timings taken by various algorithms for spam detection. Its then fetches the output from the virtual cluster to the local machine and saves it at ~/cloudmesh.kubernetes/ansiblescript/output
