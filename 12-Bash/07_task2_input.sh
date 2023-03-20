#!/bin/bash

# connect remote machine using ssh 
# run with ./07_task2_input.sh

read -p "Enter username: " username
read -p "Enter the IP: " IP

ssh $username@$IP