#!/bin/bash

# test command used to test expression or condition. if condition true then return 0 else 1 

a="Ayush"
b="Ayush"

if test "$a" = "$b"
then echo "A equal to B"
else
echo "A is not equal to B"
fi 

c=""

if test -z "$c"  #check string empty
then
echo "String is empty"
else
echo "String is not empty"
fi

d=10
e=10

if test "$d" -eq "$e"  #check string empty
then
echo "a and b equal"
else
echo "a and b not equal"
fi

#file comparisons -s (check if file empty or not)   -d (check directory or not)

if test -s hello.txt
then 
echo "File is not empty"
else
echo "File is empty"
fi

if test -d hello.txt
then 
echo "Directory"
else
echo "Not Directory"
fi