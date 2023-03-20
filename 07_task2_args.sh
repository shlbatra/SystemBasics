#!/bin/bash

# connect remote machine using ssh 
# run with ./07_task2_input.sh sahil 10.89.189.255
#whoami -> provides username

username=$1
IP=$2

ssh $username@$IP