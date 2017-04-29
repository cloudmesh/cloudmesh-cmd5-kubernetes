#!/bin/sh
cm cluster define --count 3 --secgroup=mesos-secgroup --flavor=m1.medium --image=CC-Ubuntu16.04-20161010
cm cluster allocate
