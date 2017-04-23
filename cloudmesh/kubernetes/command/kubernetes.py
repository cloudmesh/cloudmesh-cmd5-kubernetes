from __future__ import print_function
from cloudmesh.shell.command import command
from cloudmesh.shell.command import PluginCommand
from cloudmesh.common.default import Default
from cloudmesh.common.console import Console
from pprint import pprint

class KubernetesCommand(PluginCommand):

    def parse_parameters(self, arg):
        parameters = {}
        for element in arg:
            name, value = element.split("=", 1)
            parameters[name] = value
        return parameters

    @command
    def do_kubernetes(self, args, arguments):
        """
        ::

          Usage:
                kubernetes info
                kubernetes status
                kubernetes cloud CLOUD
                kubernetes image IMAGE
                kubernetes cluster inventory
                kubernetes cluster N [CLUSTER]
                kubernetes deploy [test] 
                kubernetes benchmark [PARAMETER...]

          This command does some useful things.

          Arguments:
              CLOUD      the name of the cloud
              IMAGE      the name of the image
              CLUSTER    the name of the cluster
              PARAMETER  the paramaters given in form name=value with space separated

          Options:
              -f      specify the file

        """
        # print(arguments)

        default = Default()

        if arguments.info:

            Console.error("not yet implemented")

        elif arguments.status:

            # set the status cloud
            Console.error("not yet implemented")

        elif arguments.cloud:

            default["kubernetes","cloud"] = arguments.CLOUD
        
        elif arguments.image:

            default["kubernetes","image"] = arguments.IMAGE

        elif arguments.cluster and arguments.inventory:
            # export the inventory form the deployed cluster
            # check this as N could also be inventory
            Console.error("not yet implemented")

        elif arguments.cluster:

            n = arguments.N
            name = arguments.CLUSTER
            if name is None:
                name = "TBD"
                #look up the name from the cluster defined
                pass
            default["kubernetes","cluster"] = name
            
            # set the default cluster with the new name
            Console.error("not yet implemented")

        elif arguments.deploy and arguments.test:

            # conduct a test on the deployed resources to see if everything is ok
            Console.error("not yet implemented")

        elif arguments.deploy:

            # conduct the deploy
            Console.error("not yet implemented")

        elif arguments.benchmark:

            # run the benchmakr with the list of parameters
            parameters = self.parse_parameters(arguments.PARAMETER)

            pprint (parameters)

            Console.error("not yet implemented")

        default.close()
        return ""