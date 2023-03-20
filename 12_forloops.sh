#!/bin/bash

# repetition of tasks - for, while and until (three diff ways of looping)

myarray=(A B C D E F)

echo ${myarray[@]}

# for((initiation; condition; inc/dec)) {}

for((i=0; i<5; i++))
{
    echo "Sorry";
}

# diff syntax 
for i in 1 2 3 4 5
do
    if [ $i -gt 3 ]
    then
        echo "Iteration:" $i
    fi
done

myarray=(A B C D E F G H)
# PRINT ARRAY 
for((i=0; i<7; i++))
{
    echo ${myarray[i]}
}