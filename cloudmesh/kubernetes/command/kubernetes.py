from __future__ import print_function
from cloudmesh.shell.command import command
from cloudmesh.shell.command import PluginCommand


class KubernetesCommand(PluginCommand):

    @command
    def do_kubernetes(self, args, arguments):
        """
        ::

          Usage:
                kubernetes -f FILE
                kubernetes FILE
                kubernetes list

          This command does some useful things.

          Arguments:
              FILE   a file name

          Options:
              -f      specify the file

        """
        print(arguments)



