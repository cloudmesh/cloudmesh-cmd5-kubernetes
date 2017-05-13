#!/bin/sh
cm cluster define --count 3 --flavor=m1.medium --image=Ubuntu-16.04-64 --secgroup=kub-project7
cm cluster allocate
