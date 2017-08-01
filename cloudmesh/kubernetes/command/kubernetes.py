from __future__ import print_function
from cloudmesh.shell.command import command
from cloudmesh.shell.command import PluginCommand
from cloudmesh.common.ConfigDict import ConfigDict
from cloudmesh.common.StopWatch import StopWatch
from cloudmesh.common.default import Default
from cloudmesh.common.console import Console
from pprint import pprint

import os

class KubernetesCommand(PluginCommand):
	def make_hosts(self):
		path = os.getcwd()
		os.system('~/cloudmesh.kubernetes/scripts/knownhostfileaddition.sh')
		print("saving the host file at")
		print(path)
		os.system('cm cluster inventory > ' + path + '/hosts.txt')
		f = open(path + '/hosts.txt', 'r')
		w = open(path + '/inventory.txt', 'w')
		w.write("[kubernetes-slave]\n")
		for i, line in enumerate(f):
			if i <= 1:
				continue
			else:
				w.write("node{} host=".format(i) + line)
		f.close()
		w.write("\n[kubernetes-master]\n")
		f = open(path + '/hosts.txt', 'r')
		for i, line in enumerate(f):
			if i == 1:
				w.write("node{} host=".format(i) + line)
		f.close()
		w.close()
		os.system('rm -f hosts.txt')
		os.system('cp inventory.txt ~/cloudmesh.kubernetes/ansiblescript/inventory.txt')
		os.system('cp inventory.txt ~/cloudmesh.kubernetes/inventory.txt')
	
	@command
	def do_kubernetes(self, args, arguments):
		"""
		::
	
          	Usage:
                	kubernetes name NAME
			kubernetes size SIZE
			kubernetes image IMAGE
			kubernetes flavor FLAVOR
			kubernetes cloud CLOUD
			kubernetes cluster info
			kubernetes cluster deploy
			kubernetes cluster delete
			kubernetes cluster benchmark

		Arguments:
		NAME	name of the cluster
		SIZE	size of the clusteri
		IMAGE	image of the cluster
		FLAVOR	flavor of the vm
		CLOUD	cloud on which the cluster will be created

          	This command does some useful things.
		"""
		default = Default()
		if arguments.name and arguments.NAME:
			print("Set name to {}.".format(arguments.NAME))
			default["kubernetes","name"] = arguments.NAME
		
		elif arguments.size and arguments.SIZE:
			print(" Set size to {}.".format(arguments.SIZE))
			default["kubernetes","size"] = arguments.SIZE

		elif arguments.image and arguments.IMAGE:
			print(" set image to {}.".format(arguments.IMAGE))
			default["kubernetes","image"] = arguments.IMAGE
		
		elif arguments.flavor and arguments.FLAVOR:
                        print(" set flavor to {}.".format(arguments.FLAVOR))
                        default["kubernetes","flavor"] = arguments.FLAVOR

		elif arguments.cloud and arguments.CLOUD:
			print(" set cloud to {}.".format(arguments.CLOUD))
			default["kubernetes","cloud"] = arguments.CLOUD
		
		elif arguments.cluster and arguments.info:
			print("Cluster details:")
			print("\tCloud\t: {}".format(default["kubernetes","cloud"]))
			print("\tName\t: {}".format(default["kubernetes","name"]))
			print("\tSize\t: {}".format(default["kubernetes","size"]))
			print("\tImage\t: {}".format(default["kubernetes","image"]))
			print("\tFlavor\t: {}".format(default["kubernetes","flavor"]))
			print("\nIf any of the above details are None/False,")
			print("please set them using the appropriate command, before deploying the cluster.")

		elif arguments.cluster and arguments.deploy:
			if default["kubernetes","name"] is not None and default["kubernetes","size"] is not None and default["kubernetes","image"] is not None and default["kubernetes","flavor"] is not None and default["kubernetes","cloud"] is not None:
				
				stopwatch = StopWatch()
				stopwatch.start('cluster creation for kubernetes')				

				print("Creating cluster {}...".format(default["kubernetes","name"]))
				# Define a cluster
				command = "cm cluster define --secgroup mesos-secgroup --name {} --count {} --image {} --flavor {} -C {}".format(default["kubernetes","name"], default["kubernetes","size"], default["kubernetes","image"], default["kubernetes","flavor"], default["kubernetes","cloud"])
				os.system(command)

				# Use defined cluster
				command = "cm default cloud={}".format(default["kubernetes","cloud"])
				os.system(command)

				# Use defined cluster
				command = "cm cluster use {}".format(default["kubernetes","name"])
				os.system(command)

				# Create defined cluster
				command = "cm cluster allocate"
				os.system(command)

				# Make hosts file
				self.make_hosts()

				stopwatch.stop('cluster creation for kubernetes')
				print('Time Taken for creating clusters required for kubernetes:' + str(stopwatch.get('cluster creation for kubernetes')) + 'seconds')

				stopwatch = StopWatch()
				stopwatch.start('prereq for kubernetes')

				# Run ansible script for setting up the various installables
				print("Running the setup needed for Kubernetes")
				command = 'ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/installations.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt -e "cloud={}"'.format(default["kubernetes","cloud"])
				os.system(command)

				stopwatch.stop('prereq for kubernetes')
				print('Time Taken for installing various pre requites for kubernetes:' + str(stopwatch.get('prereq for kubernetes')) + 'seconds')

				stopwatch = StopWatch()
				stopwatch.start('Kubernetes installables')				
				
				# Run ansible script for setting up kubernetes cluster
				print("Running the setup needed for Kubernetes")
				command = 'ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/kubernetes.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt -e "cloud={}"'.format(default["kubernetes","cloud"])
				os.system(command)

				stopwatch.stop('Kubernetes installables')
				print('Time Taken for installing kubernetes related packages:' + str(stopwatch.get('Kubernetes installables')) + 'seconds')

				stopwatch = StopWatch()
				stopwatch.start('Kubernetes cluster creation')

				# Run ansible script for installing kubernetes on master node
				print("Installing Kubernetes on master node")
				command = 'ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/master.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt -e "cloud={}"'.format(default["kubernetes","cloud"])
				os.system(command)

				# Run ansible script for joining slaves to master node to make a kubernetes cluster
				print("Joining the slaves")
				command = 'ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/slaves.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt -e "cloud={}"'.format(default["kubernetes","cloud"])
				os.system(command)


				stopwatch.stop('Kubernetes cluster creation')
				print('Time Taken for deploying Kubernetes cluster:' + str(stopwatch.get('Kubernetes cluster creation')))

				print("Ansible tasks have been successfully completed.")
				print("Cluster {} created and Kubernetes is running on cluster.".format(default["kubernetes","name"]))
				default["kubernetes","deploy"] = True
			else:
				print("Please set all the required variables.")

		elif arguments.cluster and arguments.benchmark:
			if default["kubernetes","name"] is not None and default["kubernetes","size"] is not None and default["kubernetes","image"] is not None and default["kubernetes","flavor"] is not None and default["kubernetes","cloud"] is not None and default["kubernetes","deploy"]:
				
				stopwatch = StopWatch()
				stopwatch.start('Kubernetes benchmark')				

				# Run ansible script for setting up 
				print("Running the setup needed for Kubernetes")
				command = 'ansible-playbook ~/cloudmesh.kubernetes/ansiblescript/runningapplicationonkubernetes.yml -i ~/cloudmesh.kubernetes/ansiblescript/inventory.txt -e "cloud={}"'.format(default["kubernetes","cloud"])
				os.system(command)

				stopwatch.stop('Kubernetes benchmark')
				print('Time Taken for running the Spam Detection application:' + str(stopwatch.get('Kubernetes benchmark')))

				print("Cluster {} created and Kubernetes is running on cluster.".format(default["kubernetes","name"]))
				default["kubernetes","deploy"] = False
			else:
				print("Please set all the required variables and deploy a kubernetes cluster before running benchmarks on it.") 
		default.close()
		return ""
