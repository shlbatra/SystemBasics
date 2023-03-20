#!/bin/bash

# access parameters passed 

echo $0
echo $1   # get first parameter, $0 -> name of script, can go till $9
echo $2

echo $@   # get all arguments passed
echo $#          # get number of arguments passed

name=$1 

echo "My name is : $name"
