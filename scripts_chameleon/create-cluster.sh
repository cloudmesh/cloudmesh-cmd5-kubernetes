#!/bin/sh
cm cluster define --count 3 --secgroup=kubernetes-secgroup --flavor=m1.medium --image=CC-Ubuntu16.04-20161214
cm cluster allocate
