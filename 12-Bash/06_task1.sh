#!/bin/bash

#read input from server ip or domain name
#ping command to ping to that server
# example command to run ./06_task1.sh -> 8.8.8.8 for google.com

read -p "Which server you want to ping ?" server_addr

ping -c3 -W5 $server_addr   # -c -> 3packets for deadline 5 sec 