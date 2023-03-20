#!/bin/bash 

echo "Variables: container which hold some values"

echo "User Defined Variables"
name="Sahil"  #no space else shell consider it as command
age=20
pointer=9.89

echo $name $age # print variables using echo
echo "My pointer is: " $pointer

echo "Environment Variables"
echo $PATH
NOW=$(date '+%F_%H:%M:%S' )
echo $SHELL $NOW

