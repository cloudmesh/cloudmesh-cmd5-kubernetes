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
		#os.system('rm -f hosts.txt')
		os.system('mv inventory.txt ~/cloudmesh.kubernetes/ansiblescript/inventory.txt')
	
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
				
				print("Creating cluster {}...".format(default["kubernetes","name"]))
				# Define a cluster
				command = "cm cluster define --name {} --count {} --image {} --flavor {} -C {}".format(default["kubernetes","name"], default["kubernetes","size"], default["kubernetes","image"], default["kubernetes","flavor"], default["kubernetes","cloud"])
				os.system(command)

				# Use defined cluster
				command = "cm cluster use {}".format(default["kubernetes","name"])
				os.system(command)

				# Create defined cluster
				command = "cm cluster allocate"
				os.system(command)

				# Make hosts file
				self.make_hosts()

				# Run ansible script
				command = '~/cloudmesh.kubernetes/scripts/deploy-kubernetes.sh'
				os.system(command)

				print("Ansible tasks have been successfully completed.")
				print("Cluster {} created and Kubernetes is running on cluster.".format(default["kubernetes","name"]))
				default["kubernetes","deploy"] = True
			else:
				print("Please set all the required variables.") 
		default.close()
		return ""
