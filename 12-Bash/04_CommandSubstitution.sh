#!/bin/bash

echo "Command Substitution Tutorial"

current_dir1=`pwd`   # use current_dir as alias to pwd command
current_dir2=$(pwd)

echo "Your current working dir is: " $current_dir1
echo "Your current working dir is: " $current_dir2

newfile=`cat>hello.txt`

echo $newfile